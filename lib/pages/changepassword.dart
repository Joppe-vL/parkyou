import 'package:flutter/material.dart';
import 'dart:async';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  Color buttonColor = Color(0xff00c1ff); // Initialize buttonColor
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0d3ff),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 170, 0, 0),
              padding: EdgeInsets.all(0),
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.zero,
                border: Border.all(color: Color(0x4d9e9e9e), width: 1),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 30, 16, 16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Change Password",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Change your password below.",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 12,
                          color: Color(0xff000000),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 16),
                        child: Text(
                          "Create  New Password",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 12,
                            color: Color(0xff494949),
                          ),
                        ),
                      ),
                      TextField(
                        controller: TextEditingController(),
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
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide:
                                BorderSide(color: Color(0x00000000), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide:
                                BorderSide(color: Color(0x00000000), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide:
                                BorderSide(color: Color(0x00000000), width: 1),
                          ),
                          hintText: "Enter New Password",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 12,
                            color: Color(0xffa4a4a4),
                          ),
                          filled: true,
                          fillColor: Color(0xfff2f2f3),
                          isDense: false,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          prefixIcon: Icon(Icons.lock_open,
                              color: Color(0xff212435), size: 24),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                        child: Text(
                          "Create  Confirm Password",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 12,
                            color: Color(0xff494949),
                          ),
                        ),
                      ),
                      TextField(
                        controller: TextEditingController(),
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
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide:
                                BorderSide(color: Color(0x00000000), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide:
                                BorderSide(color: Color(0x00000000), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide:
                                BorderSide(color: Color(0x00000000), width: 1),
                          ),
                          hintText: "Enter Confirm Password",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 12,
                            color: Color(0xffa4a4a4),
                          ),
                          filled: true,
                          fillColor: Color(0xfff2f2f3),
                          isDense: false,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          prefixIcon: Icon(Icons.lock_open,
                              color: Color(0xff212435), size: 24),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Builder(
                          builder: (context) => MaterialButton(
                            onPressed: () {
                              // To change the button color to green for 2 seconds
                              setState(() {
                                buttonColor = Colors.green;
                              });

                              // Wait for 2 seconds
                              Timer(Duration(seconds: 2), () {
                                setState(() {
                                  buttonColor = Color(0xff00c1ff);
                                });

                                // Redirect to the login screen
                                Navigator.pushReplacementNamed(
                                    context, '/accountscreen');
                              });
                            },
                            color: buttonColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(
                                  color: Color(0xff000000), width: 1),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Text(
                              "Reset Password",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            textColor: Color(0xff000000),
                            height: 45,
                            minWidth: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 100,
                  width: 100,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset("images/Bigger.png", fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
