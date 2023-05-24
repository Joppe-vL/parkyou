import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parkyou/pages/yourparkspot.dart';

class VehicleScreen extends StatelessWidget {
  Future<List<Map<String, dynamic>>> fetchLocations() async {
    try {
      final String? userUid = FirebaseAuth.instance.currentUser?.uid;
      final CollectionReference ParkSpotCollection = FirebaseFirestore.instance
          .collection('Users')
          .doc(userUid)
          .collection('Vehicles');

      final QuerySnapshot snapshot = await ParkSpotCollection.get();
      final List<Map<String, dynamic>> options = snapshot.docs.map((doc) {
        final docId = doc.id;
        final name = (doc.data() as Map<String, dynamic>)['name'] as String;
        final licensePlate =
            (doc.data() as Map<String, dynamic>)['licensePlate'] as String;
        return {
          'docId': docId,
          'name': name,
          'licensePlate': licensePlate,
        };
      }).toList();
      return options;
    } catch (e) {
      print('Error fetching location options: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
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
                "Park Spots",
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
              padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Your park spots:",
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
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchLocations(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final locations = snapshot.data!;
                    return Container(
                      height: 180,
                      child: Material(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: locations.length,
                          itemBuilder: (context, index) {
                            final name = locations[index]['name'];
                            final docId = locations[index]['docId'];
                            final licensePlate =
                                locations[index]['licensePlate'];

                            return Builder(
                              builder: (context) => GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/edit_vehiclescreen',
                                    arguments: {
                                      'docId': docId,
                                    },
                                  );
                                },
                                child: ListTile(
                                  tileColor: Color(0xffffffff),
                                  title: Text(
                                    "Vehicle Name: $name",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  subtitle: Text(
                                    "License Plate: $licensePlate",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  dense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  selected: false,
                                  selectedTileColor: Color(0x42000000),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                    side: BorderSide(
                                        color: Color(0x7f9e9e9e), width: 1),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
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
    });
  }
}
