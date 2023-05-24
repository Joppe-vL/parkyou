import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

List<String> vvehicleOptions = []; // Initialize as an empty list

class VehicleScreen extends StatefulWidget {
  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  List<String> vvehicleOptions = [
    'No vehicles'
  ]; // Initialize with a default option
  String selectedOption = 'No vehicles';
  String selectedOptionId = '';

  Future<void> getVehicleOptions() async {
    try {
      final String? userUid = FirebaseAuth.instance.currentUser?.uid;
      final CollectionReference vehiclesCollection = FirebaseFirestore.instance
          .collection('Users')
          .doc(userUid)
          .collection('Vehicles');

      final QuerySnapshot snapshot = await vehiclesCollection.get();
      final List<String> options = snapshot.docs
          .map((doc) => (doc.data() as Map<String, dynamic>)['name'] as String)
          .toList();
      setState(() {
        vvehicleOptions = options.isNotEmpty ? options : ['No vehicles'];
        selectedOption = vvehicleOptions.contains(selectedOption)
            ? selectedOption
            : vvehicleOptions[0];
      });
    } catch (e) {
      print('Error fetching vehicle options: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getVehicleOptions();
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
              "Vehicles",
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
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Container(
                      width: 130,
                      height: 50,
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: DropdownButton(
                        value: selectedOption,
                        items: vvehicleOptions.map((option) {
                          return DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value.toString();
                          });
                        },
                        elevation: 8,
                        isExpanded: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(170, 20, 10, 0),
                child: Builder(
                  builder: (context) => MaterialButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, '/edit_vehiclescreen');
                    },
                    color: Color(0xff00c1ff),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: BorderSide(color: Color(0xff000000), width: 1),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Edit Vehicle",
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
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Builder(
              builder: (context) => MaterialButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/addvehicle');
                },
                color: Color(0xff00c1ff),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  side: BorderSide(color: Color(0xff000000), width: 1),
                ),
                padding: EdgeInsets.all(16),
                child: Text(
                  "Add New Vehicle",
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
