import 'dart:html';

import 'package:carewellapp/Chat%20Application/chatViews/expanded.dart';
import 'package:carewellapp/Chat%20Application/chatViews/signup.dart';
import 'package:carewellapp/cloud_models/google_sheets_carewell_chat.dart';
import 'package:carewellapp/main.dart';
import 'package:carewellapp/navigation_elements/community.dart';
import 'package:carewellapp/navigation_elements/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carewellapp/cloud_models/google_sheets.dart';

String selection = 'General';
String post = '';
bool isComment = false;

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed.
      ChatForm feedbackForm = ChatForm(
        deviceID,
        email,
        DateTime.now().toString(),
        selection,
        message,
      );

      ChatController chatController = ChatController();

      //  _showSnackbar("Submitting Feedback");

      // Submit 'feedbackForm' and save it in Google Sheets.
      chatController.submitForm(feedbackForm, (String response) {
        print("Response: $response");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                    color: Colors.blue[700],
                    height: MediaQuery.of(context).size.height * 0.923,
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: ListView(
                      children: [
                        ListTile(
                          title: Text("General",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize:
                                      15 /*/ deviceTextScaleFactor + 2*/)),
                          onTap: () async {
                            setState(() {
                              selection = "General";
                            });
                          },
                        ),
                        ListTile(
                          title: Text("Social",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize:
                                      15 /* /  deviceTextScaleFactor + 2 */)),
                          onTap: () async {
                            setState(() {
                              selection = "Social";
                            });
                          },
                        ),
                        ListTile(
                          title: Text("Managing Care",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize:
                                      15 /*/ deviceTextScaleFactor + 2 */)),
                          onTap: () async {
                            setState(() {
                              selection = "Managing Care";
                            });
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                        ),
                        ListTile(
                          title: Text("Notifications",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize:
                                      15 /*/ deviceTextScaleFactor + 2 */)),
                          onTap: () async {},
                        ),
                        ListTile(
                          title: Text("Sign Out",
                              style: TextStyle(
                                  color: Colors.red[900],
                                  fontSize:
                                      15 /*/ deviceTextScaleFactor + 2 */)),
                          onTap: () async {
                            isComment = false;
                            var startManagingCare =
                                DateTime.now().millisecondsSinceEpoch;
                            //  onIndexChanged(2);
                            appBarText = "Sign Out";
                            var stopManagingCare =
                                DateTime.now().millisecondsSinceEpoch;
                            //  _signOut();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => dashboard()),
                            );
                          },
                        ),
                      ],
                    )),
              ]),
            ),
          ),
          feed(context, getStream()),
        ],
      ),
    );
  }
}

_FeedState fs = new _FeedState();

StreamBuilder<QuerySnapshot> messageStream(
    Stream<QuerySnapshot<Object?>> _usersStream) {
  return StreamBuilder<QuerySnapshot>(
    stream: _usersStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text("Loading");
      }

      return ListView(
        // padding: EdgeInsets.all(8.0),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

          return ListTile(
            title: Text(data['message']),
            subtitle: Text(
                data['user'] + '          ' + data['time'].toDate().toString()),
            onTap: () async {
              if (isComment) {
                return;
              }
              isComment = true;
              post = document.id;

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Comments()),
              );
              ;
            },
          );
        }).toList(),
      );
    },
  );
}

Container feed(
    BuildContext context, Stream<QuerySnapshot<Object?>> _usersStream) {
  TextEditingController messageTextEditingController =
      new TextEditingController();
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width * 0.80,

    //padding: EdgeInsets.all(5.0),
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              color: Colors.blue[900],
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  isComment ? "Comments" : selection,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25),
                ),
              )),
          Container(
            height: MediaQuery.of(context).size.height * 0.73,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(children: [
                messageStream(_usersStream),
              ]),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: messageTextEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: isComment ? "Add comment" : 'Enter a message',
                  ),
                ),
              ),
              SizedBox(
                width: 25,
              ),
              FloatingActionButton(
                child: const Icon(
                  Icons.arrow_right_rounded,
                  size: 50,
                ),
                onPressed: () async {
                  String message = messageTextEditingController.text.trim();

                  if (message.isEmpty) {
                    print("Message is empty");
                  } else {
                    if (!isComment) {
                      final message_dashboard = {
                        // PatientID, StartTimestamp, StopTimestamp, Section
                        CarewellChatModelGS.PatientID: deviceID,
                        CarewellChatModelGS.UserID: email,
                        CarewellChatModelGS.Timestamp:
                            DateTime.now().toString(),
                        CarewellChatModelGS.Channel: selection,
                        CarewellChatModelGS.Message: message,
                      };

                      fs._submitForm();

                      // Cha_submitForm();

                      await googleSheetsAPI.insertCS([message_dashboard]);
                      Future<List<Chat>> msg = getDataFromGoogleSheet();
                    } else {
                      FirebaseFirestore.instance
                          .collection(selection)
                          .doc(post)
                          .collection("comments")
                          .add({
                        'message': message,
                        'time': new Timestamp.now(),
                        'user': email,
                      });
                    }
                  }

                  messageTextEditingController.clear();
                },
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Stream<QuerySnapshot> getStream() {
  if (isComment) {
    return FirebaseFirestore.instance
        .collection(selection)
        .doc(post)
        .collection("comments")
        .orderBy('time')
        .snapshots();
  }
  return FirebaseFirestore.instance
      .collection(selection)
      .orderBy('time')
      .snapshots();
}

Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
}
