import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parkyou/pages/yourparkspot.dart';

class ParkSpotScreen extends StatelessWidget {
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
            FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchLocations(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final locations = snapshot.data!;
                  return Expanded(
                    flex: 1,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: locations.length,
                      itemBuilder: (context, index) {
                        final location = locations[index];
                        final docId = locations[index]['docId'];
                        return Builder(
                          builder: (context) => GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                '/yourparkspot',
                                arguments: {
                                  'docId': docId,
                                },
                              );
                            },
                            child: ListTile(
                              tileColor: Color(0xffffffff),
                              title: Text(
                                "Location:",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                ),
                                textAlign: TextAlign.start,
                              ),
                              subtitle: Text(
                                location[
                                    'location'], // Display "Location: [location]"
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
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
                return CircularProgressIndicator(); // or any other loading indicator widget
              },
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Reserved park spots:",
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
            FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchLocations(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final locations = snapshot.data!;
                  return Expanded(
                    flex: 1,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: locations.length,
                      itemBuilder: (context, index) {
                        final location = locations[index];
                        final docId = locations[index]['docId'];
                        return Builder(
                          builder: (context) => GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                '/yourparkspot',
                                arguments: {
                                  'docId': docId,
                                },
                              );
                            },
                            child: ListTile(
                              tileColor: Color(0xffffffff),
                              title: Text(
                                "Location:",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                ),
                                textAlign: TextAlign.start,
                              ),
                              subtitle: Text(
                                location[
                                    'location'], // Display "Location: [location]"
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
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
                return CircularProgressIndicator(); // or any other loading indicator widget
              },
            ),
          ],
        ),
      );
    });
  }
}
