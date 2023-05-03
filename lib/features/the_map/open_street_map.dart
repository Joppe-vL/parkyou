import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';
import 'package:geocoding/geocoding.dart';

class OpenStreetMap extends StatefulWidget {
  @override
  _OpenStreetMapState createState() => _OpenStreetMapState();
}

class _OpenStreetMapState extends State<OpenStreetMap> {
  LatLng? _tappedPoint;
  TextEditingController _searchController = TextEditingController();

  void _handleTap(TapPosition pos, LatLng point) {
    setState(() {
      _tappedPoint = point;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Lat: ${point.latitude}, Lng: ${point.longitude}'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  void _searchAddress() async {
    String query = _searchController.text;
    List<Location> locations = await locationFromAddress(query);
    if (locations.isNotEmpty) {
      Location location = locations.first;
      LatLng point = LatLng(location.latitude, location.longitude);
      setState(() {
        _tappedPoint = point;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for an address...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: _searchAddress,
                  child: Text('Search'),
                ),
              ],
            ),
          ),
          Expanded(
            child: FlutterMap(
              mapController: MapController(),
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
                  markers: [
                    if (_tappedPoint != null)
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: _tappedPoint!,
                        builder: (ctx) => Container(
                          child: Icon(Icons.location_pin),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
