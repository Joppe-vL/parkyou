import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Errorscreen extends StatefulWidget {
  @override
  _ErrorscreenState createState() => _ErrorscreenState();
}

class _ErrorscreenState extends State<Errorscreen> {
  DateTime currentDate = DateTime.now();
  DateTime? selectedTime1;
  DateTime? selectedTime2;

  bool isCheckboxSelected = false;
  TextEditingController time1Controller = TextEditingController();
  TextEditingController time2Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    time1Controller.text = DateFormat('HH:mm').format(currentDate);
    time2Controller.text = DateFormat('HH:mm').format(currentDate);
  }

  void checkTime() {
    if (selectedTime1 != null && selectedTime2 != null && isCheckboxSelected) {
      if (selectedTime1!.isBefore(selectedTime2!)) {
        Navigator.pushReplacementNamed(context, '/mapscreen');
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
      Navigator.pushReplacementNamed(context, '/mapscreen');
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
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
                          color: isCheckboxSelected
                              ? Color(0xff00c1ff)
                              : Colors.grey,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side:
                                BorderSide(color: Color(0xff000000), width: 1),
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
                          color: isCheckboxSelected
                              ? Color(0xff00c1ff)
                              : Colors.grey,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side:
                                BorderSide(color: Color(0xff000000), width: 1),
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
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Builder(
                  builder: (context) => MaterialButton(
                    onPressed: checkTime,
                    color: Color(0xffff0004),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: BorderSide(color: Color(0xff000000), width: 1),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "CheckTime",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    textColor: Color(0xff000000),
                    height: 40,
                    minWidth: 120,
                  ),
                ),
              ),
            ]));
  }
}
