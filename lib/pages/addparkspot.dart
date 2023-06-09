import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddParkSpot extends StatefulWidget {
  @override
  _AddParkSpotState createState() => _AddParkSpotState();
}

class _AddParkSpotState extends State<AddParkSpot> {
  String location = '';
  DateTime currentDate = DateTime.now();
  DateTime? selectedDate1 = DateTime.now();
  DateTime? selectedDate2 = DateTime.now();
  TextEditingController date1Controller = TextEditingController();
  TextEditingController date2Controller = TextEditingController();
  bool isDate2Error = false;
  Color date2ButtonColor = Color(0xff00c1ff);
  TextEditingController time1Controller = TextEditingController();
  TextEditingController time2Controller = TextEditingController();
  DateTime? selectedTime1 = DateTime.now();
  DateTime? selectedTime2 = DateTime.now();
  bool isCheckboxSelected = false;

  @override
  void initState() {
    super.initState();
    fetchLocation();
    selectedDate1 = currentDate;
    selectedDate2 = currentDate;
    time1Controller.text = DateFormat('HH:mm').format(currentDate);
    time2Controller.text = DateFormat('HH:mm').format(currentDate);
  }

  Future<void> fetchLocation() async {
    final fetchedLocation = await fetchDeviceLocation();
    final simplifiedLocation = _simplifyAddress(fetchedLocation);

    setState(() {
      location = simplifiedLocation;
    });
  }

  Future<void> selectDate1(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate1) {
      setState(() {
        selectedDate1 = picked;
      });
    }
  }

  Future<void> selectDate2(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate2) {
      setState(() {
        selectedDate2 = isCheckboxSelected ? null : picked;
        if (selectedDate1 != null && selectedDate2 != null) {
          if (selectedDate2!.isBefore(selectedDate1!)) {
            date2ButtonColor = Color(0xffff0004);
          } else {
            date2ButtonColor = Color(0xff00c1ff);
          }
        }
      });
    }
  }

  void checkTime() {
    if (selectedTime1 != null && selectedTime2 != null && isCheckboxSelected) {
      if (selectedTime1!.isBefore(selectedTime2!)) {
        String? userUid = FirebaseAuth.instance.currentUser?.uid;
        CollectionReference parkSpots = FirebaseFirestore.instance
            .collection('Users')
            .doc(userUid)
            .collection('Park_Spots');
        String thetime = DateFormat('hh:mm a').format(selectedTime1!);
        String thetime2 = DateFormat('hh:mm a').format(selectedTime2!);
        //String thedate = DateFormat('dd-MM-yyyy').format(selectedDate1!); This makes the whole code crash
        //String thedate2 = DateFormat('dd-MM-yyyy').format(selectedDate2!); This makes the whole code crash
        parkSpots.add({
          'location': location,
          'startTime': thetime,
          'endTime': thetime2,
          'startDate': selectedDate1,
          'endDate': null,
          'isReserved': false,
          'isParked': false,
          'number_Plate_Parked_Vehicle': null,
          'name_Parked_Vehicle': null
        }).then((value) {
          Navigator.pushReplacementNamed(context, '/mapscreen');
        });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid Time'),
              content:
                  Text('The start time must be earlier than the end time.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else if (!isCheckboxSelected) {
      String? userUid = FirebaseAuth.instance.currentUser?.uid;
      CollectionReference parkSpots = FirebaseFirestore.instance
          .collection('Users')
          .doc(userUid)
          .collection('Park_Spots');
      String thetime = DateFormat('hh:mm a').format(selectedTime1!);
      String thetime2 = DateFormat('hh:mm a').format(selectedTime2!);
      //String thedate = DateFormat('dd-MM-yyyy').format(selectedDate1!);
      //String thedate2 = DateFormat('dd-MM-yyyy').format(selectedDate2!);

      parkSpots.add({
        'location': location,
        'startTime': null,
        'endTime': null,
        'startDate': selectedDate1,
        'endDate': selectedDate2,
        'isReserved': false,
        'isParked': false,
        'number_Plate_Parked_Vehicle': null,
        'name_Parked_Vehicle': null
      }).then((value) {
        Navigator.pushReplacementNamed(context, '/mapscreen');
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed')),
        );
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid Time'),
            content: Text('Please select both start and end times.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void validateAndNavigate() {
    if (selectedDate1 != null && selectedDate2 != null && !isCheckboxSelected) {
      if (selectedDate2!.isBefore(selectedDate1!)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Invalid date selection."),
              content: Text("End date cannot be earlier than start date."),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        checkTime(); // Call checkTime function to validate time
      }
    } else if (selectedDate1 != null && isCheckboxSelected) {
      selectedDate2 = null; // Set selectedDate2 to null for one-day parking
      checkTime(); // Call checkTime function to validate time
    } else {
      // Handle case when dates are not selected
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please select both dates."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

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
            child: Image(
              image: AssetImage("assets/images/Bigger.png"),
              height: 100,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Text(
              "Add Parking Spot",
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
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                  onChanged: (value) {
                    setState(() {
                      isCheckboxSelected = value!;
                      selectedTime1 = null;
                      selectedTime2 = null;
                    });
                  },
                  activeColor: Color(0xff3a57e8),
                  autofocus: false,
                  checkColor: Color(0xffffffff),
                  hoverColor: Color(0x42000000),
                  splashRadius: 20,
                  value: isCheckboxSelected,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                        "$location",
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
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                      onPressed: () {
                        if (!isCheckboxSelected) return;
                        DatePicker.showTimePicker(
                          context,
                          showTitleActions: true,
                          onChanged: (dateTime) {
                            // Update the selected time in the state
                            setState(() {
                              selectedTime1 = dateTime;
                            });
                          },
                          onConfirm: (dateTime) {
                            // Update the selected time in the state
                            setState(() {
                              selectedTime1 = dateTime;
                            });
                          },
                          currentTime: selectedTime1 ?? DateTime.now(),
                        );
                      },
                      color:
                          isCheckboxSelected ? Color(0xff00c1ff) : Colors.grey,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Color(0xff000000), width: 1),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(
                        selectedTime1 != null
                            ? DateFormat('hh:mm a').format(selectedTime1!)
                            : 'Select Time',
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
                      onPressed: () {
                        if (!isCheckboxSelected) return;
                        DatePicker.showTimePicker(
                          context,
                          showTitleActions: true,
                          onChanged: (dateTime) {
                            // Update the selected time in the state
                            setState(() {
                              selectedTime2 = dateTime;
                            });
                          },
                          onConfirm: (dateTime) {
                            // Update the selected time in the state
                            setState(() {
                              selectedTime2 = dateTime;
                            });
                          },
                          currentTime: selectedTime2 ?? DateTime.now(),
                        );
                      },
                      color:
                          isCheckboxSelected ? Color(0xff00c1ff) : Colors.grey,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Color(0xff000000), width: 1),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(
                        selectedTime2 != null
                            ? DateFormat('hh:mm a').format(selectedTime2!)
                            : 'Select Time',
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
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                      onPressed: () => selectDate1(context),
                      color: Color(0xff00c1ff),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Color(0xff000000), width: 1),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(
                        selectedDate1 != null
                            ? DateFormat('dd-MM-yyyy').format(selectedDate1!)
                            : DateFormat('dd-MM-yyyy').format(currentDate),
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
                Visibility(
                  visible: !isCheckboxSelected,
                  child: Padding(
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
                ),
                Visibility(
                  visible: !isCheckboxSelected,
                  child: Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: MaterialButton(
                        onPressed: () => selectDate2(context),
                        color: date2ButtonColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(color: Color(0xff000000), width: 1),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          selectedDate2 != null
                              ? DateFormat('dd-MM-yyyy').format(selectedDate2!)
                              : isCheckboxSelected
                                  ? 'N/A'
                                  : DateFormat('dd-MM-yyyy')
                                      .format(currentDate),
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
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Builder(
              builder: (context) => MaterialButton(
                onPressed: () {
                  validateAndNavigate();
                },
                color: Color(0xff00c1ff),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: BorderSide(color: Color(0xff000000), width: 1),
                ),
                padding: EdgeInsets.all(16),
                child: Text(
                  "Add Parking spot",
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
