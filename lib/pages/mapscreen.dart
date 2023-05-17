import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

class OpenStreetMap extends StatefulWidget {
  @override
  _OpenStreetMapState createState() => _OpenStreetMapState();
}

class _OpenStreetMapState extends State<OpenStreetMap> {
  bool _showAddressSnackBar = false;
  String _addressSnackBarText = '';

  LatLng? _tappedPoint;
  TextEditingController _searchController = TextEditingController();
  MapController _mapController = MapController();
  List<Marker> _markers = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference locations =
      FirebaseFirestore.instance.collection('parking_spots');

  Future<void> _getLocations() async {
    QuerySnapshot querySnapshot = await locations.get();

    querySnapshot.docs.forEach((document) {
      GeoPoint geoPoint = document.get('location');
      DateTime startDate = document.get('startTime').toDate();
      DateTime endDate = document.get('endTime').toDate();
      bool reserved = document.get('reserved');
      String userID = document.get('userId');

      if (reserved &&
          DateTime.now().isAfter(startDate) &&
          DateTime.now().isBefore(endDate)) {
        _markers.add(Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(geoPoint.latitude, geoPoint.longitude),
          builder: (ctx) => Container(
            child: Icon(Icons.close),
          ),
        ));
      } else {
        _markers.add(Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(geoPoint.latitude, geoPoint.longitude),
          builder: (ctx) => Container(
            child: Icon(Icons.location_pin),
          ),
        ));
      }
    });

    setState(() {});
  }

  void _handleTap(TapPosition pos, LatLng point) async {
    setState(() {
      _tappedPoint = point;
      _markers.clear();
      _markers.add(Marker(
        width: 80.0,
        height: 80.0,
        point: _tappedPoint!,
        builder: (ctx) => Container(
          child: Icon(Icons.location_pin),
        ),
      ));
    });

    final address = await _getAddress(point.latitude, point.longitude);
    final simplifiedAddress = _simplifyAddress(address);

    setState(() {
      _showAddressSnackBar = true;
      _addressSnackBarText = 'Address: $simplifiedAddress';
    });
  }

  Future<void> _handleSearch() async {
    final query = _searchController.text;
    if (query.isEmpty) {
      return;
    }
    final url =
        'https://nominatim.openstreetmap.org/search?q=${query}&format=json&addressdetails=1&limit=1';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to search for location'),
          behavior: SnackBarBehavior.fixed,
          action: SnackBarAction(
            label: 'OK',
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          ),
        ),
      );
      return;
    }

    final data = json.decode(response.body);
    if (data == null || data.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Location not found'),
          behavior: SnackBarBehavior.fixed,
          action: SnackBarAction(
            label: 'OK',
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          ),
        ),
      );
      return;
    }

    final lat = double.parse(data[0]['lat']);
    final lon = double.parse(data[0]['lon']);
    final displayName = data[0]['display_name'];

    final point = LatLng(lat, lon);

    final address = _simplifyAddress(displayName);

    setState(() {
      _addressSnackBarText = 'Address: $address';
      _showAddressSnackBar = true;
      _tappedPoint = point;
      _markers.clear();
      _markers.add(Marker(
        width: 80.0,
        height: 80.0,
        point: _tappedPoint!,
        builder: (ctx) => Container(
          child: Icon(Icons.location_pin),
        ),
      ));
    });

    _mapController.move(point, 15.0);
  }

  @override
  void initState() {
    super.initState();
    _getLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search location',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                suffixIcon: IconButton(
                  onPressed: _handleSearch,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: LatLng(51.2194, 4.4025),
                zoom: 13.0,
                onTap: _handleTap,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers: _markers,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Material(
              color: Colors.transparent,
              child: Builder(
                builder: (context) => FloatingActionButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/reserveparkspot');
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ),
          ),
          SizedBox(width: 16.0),
          FloatingActionButton(
            onPressed: _handleSearch,
            child: Icon(Icons.search),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: _showAddressSnackBar
          ? Container(
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_addressSnackBarText),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}

Future<String> _getAddress(double latitude, double longitude) async {
  final url =
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode != 200) {
    return 'Failed to retrieve address';
  }

  final data = json.decode(response.body);
  final address = data['display_name'];
  return address;
}

String _simplifyAddress(String displayName) {
  final addressComponents = displayName.split(', ');
  final streetNumber = addressComponents.length > 0 ? addressComponents[0] : '';
  final streetName = addressComponents.length > 1 ? addressComponents[1] : '';
  final city = addressComponents.length > 2 ? addressComponents[2] : '';
  return '$streetName $streetNumber, $city';
}
