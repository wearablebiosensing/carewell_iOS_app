import 'package:carewellapp/Chat%20Application/chatViews/feed.dart';
import 'package:carewellapp/Chat%20Application/chatViews/feed_widgets.dart';
import 'package:carewellapp/Chat%20Application/chatViews/signup.dart';
import 'package:carewellapp/Chat%20Application/chatViews/userinfo.dart';
import 'package:carewellapp/Chat%20Application/widgets/widget.dart';
import 'package:carewellapp/navigation_elements/dashboard.dart';
import 'package:carewellapp/navigation_elements/home.dart';
import 'package:carewellapp/questionnaire/initial_questionnaire_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

//Used to sign a user into the application. Confirms username and password w/ firebase and firebase auth.

FirebaseAuth chatuser = FirebaseAuth.instance;
String username = '';
String email = '';

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
        appBar: appBarMain(context),
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
                      style:
                          new TextStyle(color: Colors.grey[700], fontSize: 12),
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
                    } else {
                      if (password.isEmpty) {
                        print("Password is empty");
                      } else {
                        FirebaseAuth.instance
                            .authStateChanges()
                            .listen((User? user) async {
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                                    email: email, password: password);

                            if (user == null) {
                              print('User is currently signed out!');
                            } else {
                              print('User is signed in!');

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        init_question_controller() /*MyHome1Page("TITLE")*/),
                              );
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            }
                          }
                        });
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
                        style:
                            new TextStyle(color: Colors.white70, fontSize: 17)),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
//Checks username and password
                GestureDetector(
                  onTap: () {
                    email = emailTextEditingController.text.trim();
                    final String password =
                        passwordTextEditingController.text.trim();

                    if (email.isEmpty) {
                      print("Email is empty");
                    } else if (password.isEmpty) {
                      print("Password is empty");
                    } else {
                      FirebaseFirestore.instance
                          .collection('Users')
                          .add({'username': email, 'password': password});
                      username = email;
                      print("LLLLLLLL" + username);
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(30)),
                    //Google sign up not implemented yet
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
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                    RichText(
                      text: TextSpan(
                          text: "Register Now",
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()),
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
