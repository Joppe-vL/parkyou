import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReleaseParkSpot extends StatefulWidget {
  @override
  _ReleaseParkSpotState createState() => _ReleaseParkSpotState();
}

class _ReleaseParkSpotState extends State<ReleaseParkSpot> {
  Future<List<Map<String, dynamic>>> fetchLocations() async {
    try {
      final String? userUid = FirebaseAuth.instance.currentUser?.uid;
      final CollectionReference ParkSpotCollection = FirebaseFirestore.instance
          .collection('Users')
          .doc(userUid)
          .collection('Park_Spots');

      final QuerySnapshot snapshot = await ParkSpotCollection.get();
      final List<Map<String, dynamic>> options = snapshot.docs.map((doc) {
        final docId = doc.id;
        final location =
            (doc.data() as Map<String, dynamic>)['location'] as String;
        return {
          'docId': docId,
          'location': location,
        };
      }).toList();
      return options;
    } catch (e) {
      print('Error fetching location options: $e');
      return [];
    }
  }

  TextEditingController time1Controller = TextEditingController();
  DateTime? selectedTime1;
  String selectedTime = "Text";

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
                "ReleaseParkSpot",
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
                  "Your bookings:",
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
                            final name = locations[index]['location'];
                            final docId = locations[index]['docId'];

                            return Builder(
                              builder: (context) => GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/releasechoice',
                                    arguments: {
                                      'docId': docId,
                                    },
                                  );
                                },
                                child: ListTile(
                                  tileColor: Color(0xffffffff),
                                  title: Text(
                                    "Location: $name",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  subtitle: Text(
                                    "",
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
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [],
              ),
            ),
          ],
        ),
      );
    });
  }
}
