import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountScreen extends StatelessWidget {
  Future<String> getUsernameFromFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null){
      final usersCollection = FirebaseFirestore.instance.collection('Users');
      final userDoc = await usersCollection.doc(user.uid).get();
      final username = userDoc['name'] as String;
      return username;
    } else {
      // User is not logged in or authentication failed
      return 'Not logged in or failed';
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
              "Account",
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
                    "Username:",
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
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    padding: EdgeInsets.zero,
                    width: 190,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(0x1f000000),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                      child: FutureBuilder<String>(
                        future: getUsernameFromFirestore(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            // While waiting for the data to load, show a loading indicator.
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            // If an error occurs while fetching the data, display an error message.
                            return Text('Error: ${snapshot.error}');
                          } else {
                            // Once the data is loaded, display the username in the Text widget.
                            final username = snapshot.data;
                            return Text(
                              username ?? 'Username not found',
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
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
                          Navigator.pushReplacementNamed(
                              context, '/changepassword');
                        },
                        color: Color(0xffffffff),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Color(0xff000000), width: 1),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Change Password",
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
                    padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                    child: Builder(
                      builder: (context) => MaterialButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/loginscreen');
                        },
                        color: Color(0xff00c1ff),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(color: Color(0xff000000), width: 1),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Log out",
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
