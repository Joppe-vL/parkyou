import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Registerscreen extends StatefulWidget {
  @override
  _RegisterscreenState createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  Color buttonColor = Color(0xff00c1ff);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController controllerMail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerName = TextEditingController();

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff1f1f1),
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  color: Color(0xfff0d3ff),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                  border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 70,
                        width: 70,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child:
                            Image.asset("images/Bigger.png", fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: Text(
                        "Register",
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
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 30, 16, 16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextField(
                        controller: controllerName,
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
                            borderRadius: BorderRadius.circular(22.0),
                            borderSide:
                                BorderSide(color: Color(0xffffffff), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22.0),
                            borderSide:
                                BorderSide(color: Color(0xffffffff), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22.0),
                            borderSide:
                                BorderSide(color: Color(0xffffffff), width: 1),
                          ),
                          hintText: "Full Name",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                          filled: true,
                          fillColor: Color(0xfffefeff),
                          isDense: false,
                          contentPadding: EdgeInsets.all(8),
                          prefixIcon: Icon(Icons.person,
                              color: Color(0xff000000), size: 24),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: TextField(
                          controller: controllerMail,
                          obscureText: false,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 12,
                            color: Color(0xff000000),
                          ),
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0),
                              borderSide: BorderSide(
                                  color: Color(0xffffffff), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0),
                              borderSide: BorderSide(
                                  color: Color(0xffffffff), width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0),
                              borderSide: BorderSide(
                                  color: Color(0xffffffff), width: 1),
                            ),
                            hintText: "Email",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            filled: true,
                            fillColor: Color(0xffffffff),
                            isDense: false,
                            contentPadding: EdgeInsets.all(8),
                            prefixIcon: Icon(Icons.mail,
                                color: Color(0xff000000), size: 24),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: TextField(
                          controller: controllerPassword,
                          obscureText: obscurePassword,
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
                              borderRadius: BorderRadius.circular(22.0),
                              borderSide: BorderSide(
                                  color: Color(0xffffffff), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0),
                              borderSide: BorderSide(
                                  color: Color(0xffffffff), width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0),
                              borderSide: BorderSide(
                                  color: Color(0xffffffff), width: 1),
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xff000000),
                            ),
                            filled: true,
                            fillColor: Color(0xffffffff),
                            isDense: false,
                            contentPadding: EdgeInsets.all(8),                                                            
                            prefixIcon: IconButton(                              
                              icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off,
                                color: Color(0xff000000), size: 24),                            
                              onPressed: () {
                              // Toggle the password visibility state
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Builder(
                          builder: (context) => MaterialButton(
                            onPressed: () async {
                              setState(() {
                                buttonColor = Colors.green;
                              });

                              try {
                                UserCredential userCredential = 
                                  await _auth.createUserWithEmailAndPassword(email: controllerMail.text, password: controllerPassword.text);

                                String userUid = userCredential.user!.uid; 

                                await _firestore.collection('Users').doc(userUid).set({
                                  'name': controllerName.text,
                                  'email': controllerMail.text,
                                });                   

                              setState(() {
                                buttonColor = Color(0xff00c1ff);
                              });

                                // Redirect to the login screen
                                Navigator.pushReplacementNamed(
                                    context, '/loginscreen');
                              } catch (e){
                                 setState( (){
                                  buttonColor = Color(0xff00c1ff);
                                 });
                              }
                            },
                            color: buttonColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0),
                              side: BorderSide(
                                  color: Color(0xff000000), width: 1),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 16,
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
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Already have an account?",
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
                      padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, '/loginscreen');
                        },
                        child: Text(
                          "Login",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff3a57e8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
