import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<String> rvehicleOptions = [
  "Option 1",
  "Option 2",
  "Option 3"
]; // Unique values

class ReserveParkSpot extends StatefulWidget {
  @override
  _ReserveParkSpotState createState() => _ReserveParkSpotState();
}

class _ReserveParkSpotState extends State<ReserveParkSpot> {
  String selectedOption = "Option 1";
/*  String location = '';

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  Future<void> fetchLocation() async {
    final fetchedLocation = await fetchDeviceLocation();
    final simplifiedLocation = _simplifyAddress(fetchedLocation);

    setState(() {
      location = simplifiedLocation;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0d3ff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
            child:

                ///***If you have exported images you must have to copy those images in assets/images directory.
                Image(
              image: AssetImage("assets/images/Bigger.png"),
              height: 100,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Text(
              "Reserve Parking Spot",
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 20,
                color: Color(0xff000000),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Text(
                    "One day:",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Checkbox(
                  onChanged: (value) {},
                  activeColor: Color(0xff3a57e8),
                  autofocus: false,
                  checkColor: Color(0xffffffff),
                  hoverColor: Color(0x42000000),
                  splashRadius: 20,
                  value: true,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Text(
                    "Location:",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    padding: EdgeInsets.all(0),
                    width: 200,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(0x1f000000),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                      child: Text(
                        "location of firebase",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 18, 0),
                  child: Text(
                    "Vehicle:",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Container(
                      width: 130,
                      height: 40,
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: DropdownButton(
                        value: "Option 1",
                        items: ["Option 1"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                        onChanged: (value) {},
                        elevation: 8,
                        isExpanded: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Text(
                    "Time available:",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    padding: EdgeInsets.all(0),
                    width: 200,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(0x1f000000),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Time1",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text(
                              "-",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text(
                              "Time2",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 40, 0),
                  child: Text(
                    "Time:",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: MaterialButton(
                      onPressed: () {},
                      color: Color(0xff00c1ff),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Color(0xff000000), width: 1),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Time1",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      textColor: Color(0xff000000),
                      height: 40,
                      minWidth: 90,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Text(
                    "To",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: MaterialButton(
                      onPressed: () {},
                      color: Color(0xff00c1ff),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Color(0xff000000), width: 1),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Time2",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      textColor: Color(0xff000000),
                      height: 40,
                      minWidth: 90,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Text(
                    "Date available:",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    padding: EdgeInsets.zero,
                    width: 200,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(0x1f000000),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Date1",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text(
                              "-",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text(
                              "Date2",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 40, 0),
                  child: Text(
                    "Date:",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: MaterialButton(
                      onPressed: () {},
                      color: Color(0xff00c1ff),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Color(0xff000000), width: 1),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Date1",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      textColor: Color(0xff000000),
                      height: 40,
                      minWidth: 90,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Text(
                    "To",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: MaterialButton(
                      onPressed: () {},
                      color: Color(0xff00c1ff),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Color(0xff000000), width: 1),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Date2",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      textColor: Color(0xff000000),
                      height: 40,
                      minWidth: 90,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Builder(
              builder: (context) => MaterialButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/mapscreen');
                },
                color: Color(0xff00c1ff),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: BorderSide(color: Color(0xff000000), width: 1),
                ),
                padding: EdgeInsets.all(16),
                child: Text(
                  "Reserve",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                textColor: Color(0xff000000),
                height: 40,
                minWidth: 140,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
Future<String> fetchDeviceLocation() async {
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  final url =
      'https://nominatim.openstreetmap.org/reverse?lat=${position.latitude}&lon=${position.longitude}&format=json';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final displayName = data['display_name'];
    return displayName;
  } else {
    return 'Error retrieving location';
  }
}

String _simplifyAddress(String displayName) {
  final addressComponents = displayName.split(', ');
  final streetNumber = addressComponents.length > 0 ? addressComponents[0] : '';
  final streetName = addressComponents.length > 1 ? addressComponents[1] : '';
  final city = addressComponents.length > 2 ? addressComponents[2] : '';
  return '$streetName $streetNumber, $city';
}
*/