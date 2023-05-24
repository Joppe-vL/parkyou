import 'package:flutter/material.dart';
import 'package:parkyou/pages/vehiclescreen.dart';
import 'package:parkyou/features/navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditVehicle extends StatefulWidget {
  final String docId;

  EditVehicle({required this.docId});
  @override
  _EditVehicleState createState() => _EditVehicleState();
}

class _EditVehicleState extends State<EditVehicle> {
  String licensePlateNumber = '';

  Future<void> removeVehicle() async {
    try {
      final String? userUid = FirebaseAuth.instance.currentUser?.uid;
      final DocumentReference vehicleRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(userUid)
          .collection('Vehicles')
          .doc(widget.docId);

      await vehicleRef.delete();
      print('Vehicle removed successfully');
    } catch (e) {
      print('Error removing vehicle: $e');
    }
  }

  Future<void> updateVehicleName(String name) async {
    if (name.isEmpty) {
      print('Name cannot be empty');
      return;
    }

    try {
      final String? userUid = FirebaseAuth.instance.currentUser?.uid;
      final DocumentReference vehicleRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(userUid)
          .collection('Vehicles')
          .doc(widget.docId);

      await vehicleRef.update({'name': name});
      print('Vehicle name updated successfully');
    } catch (e) {
      print('Error updating vehicle name: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getLicensePlateNumber();
  }

  Future<void> getLicensePlateNumber() async {
    try {
      final String? userUid = FirebaseAuth.instance.currentUser?.uid;
      final DocumentSnapshot vehicleSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userUid)
          .collection('Vehicles')
          .doc(widget.docId)
          .get();

      if (vehicleSnapshot.exists) {
        final Map<String, dynamic>? vehicleData = vehicleSnapshot.data()
            as Map<String, dynamic>?; // Add the cast here
        if (vehicleData != null && vehicleData.containsKey('licensePlate')) {
          setState(() {
            licensePlateNumber = vehicleData['licensePlate']
                as String; // Cast the value as String
          });
        }
      }
    } catch (e) {
      print('Error retrieving license plate number: $e');
    }
  }

  TextEditingController nameController = TextEditingController();
  String newName = '';

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
              "Edit Vehicle",
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
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    "Name:",
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
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: TextField(
                      controller: nameController,
                      onChanged: (value) {
                        setState(() {
                          newName = value;
                        });
                      },
                      obscureText: false,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              BorderSide(color: Color(0xff000000), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              BorderSide(color: Color(0xff000000), width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide:
                              BorderSide(color: Color(0xff000000), width: 1),
                        ),
                        hintText: "Enter Text",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                        filled: true,
                        fillColor: Color(0xfff2f2f3),
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    "License Plate Number:",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: Text(
                      "$licensePlateNumber",
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
          Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Builder(
                      builder: (context) => MaterialButton(
                        onPressed: () {
                          removeVehicle();
                          Navigator.pushReplacementNamed(
                              context, '/vehiclescreen');
                        },
                        color: Color(0xffff0004),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Color(0xff000000), width: 1),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Remove Vehicle",
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
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Builder(
                      builder: (context) => MaterialButton(
                        onPressed: () {
                          String newName = nameController.text.trim();
                          updateVehicleName(newName);
                          Navigator.pushReplacementNamed(
                              context, '/vehiclescreen');
                        },
                        color: Color(0xff00c1ff),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(color: Color(0xff000000), width: 1),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                            fontSize: 14,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
