import 'package:carewellapp/Chat%20Application/chatViews/signin.dart';
import 'package:carewellapp/Chat%20Application/widgets/widget.dart';
import 'package:carewellapp/cloud_models/google_sheets_carewell_chat.dart';
import 'package:carewellapp/cloud_models/google_sheets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

//FirebaseAuth chatuser = FirebaseAuth.instance;
//String username = '';
String email = 'Not actually signed in';

String message = '';

//Create a database methods file which will update with the user's information.
//38:00 pt 2 flutter chat app tutorial video
//I don't think you need to store passwords in firebase

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailTextEditingController =
      new TextEditingController();

  TextEditingController passwordTextEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMain(context),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Make these all have controller: properties
                TextField(
                  controller: emailTextEditingController,
                  decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey[500])),
                ),

                TextField(
                  controller: passwordTextEditingController,
                  decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey[500])),
                ),

                SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      message,
                      style:
                          new TextStyle(color: Colors.red[700], fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),

                GestureDetector(
                  onTap: () async {
                    email = emailTextEditingController.text.trim();

                    final String password =
                        passwordTextEditingController.text.trim();

                    if (email.isEmpty) {
                      print("Email is empty");
                      setState(() {
                        message = "Email is empty";
                      });
                    } else {
                      if (password.isEmpty) {
                        print("Password is empty");
                        setState(() {
                          message = "Password is empty";
                        });
                      } else {
                        print("HERE");

                        var bytes = utf8.encode(password); // data being hashed

                        var digest = sha1.convert(bytes).toString();
                        //initPlatformState();
                        final sign_up_data_dasboard = {
                          // PatientID, StartTimestamp, StopTimestamp, Section
                          SignUpModelGS.DeviceID: "temp",
                          SignUpModelGS.Email: email,
                          SignUpModelGS.HashPassword: digest,
                          SignUpModelGS.Timestamp: DateTime.now().toString()
                        };
                        await googleSheetsAPI.insertSU([sign_up_data_dasboard]);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                        );
                      }
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        // ignore: prefer_const_constructors
                        gradient: LinearGradient(
                            //blue color background
                            colors: [Color(0xff007EF4), Color(0xff2A75BC)]),
                        borderRadius: BorderRadius.circular(30)),
                    child: Text("Sign Up",
                        style:
                            new TextStyle(color: Colors.white70, fontSize: 17)),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),

                GestureDetector(
                  onTap: () {
                    final String email = emailTextEditingController.text.trim();
                    final String password =
                        passwordTextEditingController.text.trim();

                    if (email.isEmpty) {
                      print("Email is empty");
                    } else {
                      if (password.isEmpty) {
                        print("Password is empty");
                      } else {
                        // FirebaseFirestore.instance
                        //     .collection('Users')
                        //     .add({'username': email, 'password': password});
                      }
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text("Sign Up with Google",
                        style:
                            new TextStyle(color: Colors.black87, fontSize: 17)),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                    RichText(
                      text: TextSpan(
                          text: "Sign In Now",
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()),
                              );
                            }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
