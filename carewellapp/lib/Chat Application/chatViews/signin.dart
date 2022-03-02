import 'package:carewellapp/Chat%20Application/chatViews/feed.dart';
import 'package:carewellapp/Chat%20Application/chatViews/signup.dart';
import 'package:carewellapp/cloud_models/google_sheets_carewell_chat.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carewellapp/cloud_models/google_sheets.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

String username = '';
//String email = 'Not actually signed in';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailTextEditingController =
      new TextEditingController();

  TextEditingController passwordTextEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          children: [
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
                  "Forgot Password?",
                  style: new TextStyle(color: Colors.grey[700], fontSize: 12),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () async {
                final String email = emailTextEditingController.text.trim();

                final String password =
                    passwordTextEditingController.text.trim();

                if (email.isEmpty) {
                  print("Email is empty");
                } else {
                  if (password.isEmpty) {
                    print("Password is empty");
                  } else {
                    var bytes = utf8.encode(password); // data being hashed

                    var digest = sha1.convert(bytes).toString();
                    if ((await googleSheetsAPI.verifyLogin(email, digest)) ==
                        true) {
                      username = email;

                      var bytes = utf8.encode(password); // data being hashed

                      var digest = sha1.convert(bytes).toString();
                      //initPlatformState();
                      final sign_in_data_dasboard = {
                        // PatientID, StartTimestamp, StopTimestamp, Section
                        SignUpModelGS.DeviceID: "temp",
                        SignUpModelGS.Email: email,
                        SignUpModelGS.HashPassword: digest,
                        SignUpModelGS.Timestamp: DateTime.now().toString()
                      };
                      await googleSheetsAPI.insertSI([sign_in_data_dasboard]);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Feed()),
                      );
                    }
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff007EF4), Color(0xff2A75BC)]),
                    borderRadius: BorderRadius.circular(30)),
                child: Text("Sign In",
                    style: new TextStyle(color: Colors.white70, fontSize: 17)),
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
                    username = email;
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
                    style: new TextStyle(color: Colors.black87, fontSize: 17)),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.black87, fontSize: 14),
                ),
                RichText(
                  text: TextSpan(
                      text: "Register Now",
                      style: TextStyle(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
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
