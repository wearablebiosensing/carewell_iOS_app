import 'package:carewellapp/Chat%20Application/chatViews/signin.dart';
import 'package:carewellapp/main.dart';
import 'package:carewellapp/navigation_elements/community.dart';
import 'package:carewellapp/navigation_elements/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('Chats')
      .orderBy('time')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Column(children: [
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
                            fontSize: 15 /*/ deviceTextScaleFactor + 2*/)),
                    onTap: () async {
                      var startDashboard =
                          DateTime.now().millisecondsSinceEpoch;

                      appBarText = "General";

                      var stopDashboard = DateTime.now().millisecondsSinceEpoch;

                      final usage_data_dasboard = {};
                    },
                  ),
                  ListTile(
                    title: Text("Social",
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15 /* /  deviceTextScaleFactor + 2 */)),
                    onTap: () async {
                      var startEducation =
                          DateTime.now().millisecondsSinceEpoch;
                      //  onIndexChanged(1);
                      appBarText = "Social";
                      var stopEducation = DateTime.now().millisecondsSinceEpoch;
                    },
                  ),
                  ListTile(
                    title: Text("Managing Care",
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15 /*/ deviceTextScaleFactor + 2 */)),
                    onTap: () async {
                      var startManagingCare =
                          DateTime.now().millisecondsSinceEpoch;
                      //  onIndexChanged(2);
                      appBarText = "Managing Care";
                      var stopManagingCare =
                          DateTime.now().millisecondsSinceEpoch;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                  ),
                  ListTile(
                    title: Text("Notifications",
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15 /*/ deviceTextScaleFactor + 2 */)),
                    onTap: () async {
                      var startManagingCare =
                          DateTime.now().millisecondsSinceEpoch;
                      //  onIndexChanged(2);
                      appBarText = "Notifications";
                      var stopManagingCare =
                          DateTime.now().millisecondsSinceEpoch;
                    },
                  ),
                  ListTile(
                    title: Text("Sign Out",
                        style: TextStyle(
                            color: Colors.red[900],
                            fontSize: 15 /*/ deviceTextScaleFactor + 2 */)),
                    onTap: () async {
                      var startManagingCare =
                          DateTime.now().millisecondsSinceEpoch;
                      //  onIndexChanged(2);
                      appBarText = "Sign Out";
                      var stopManagingCare =
                          DateTime.now().millisecondsSinceEpoch;
                      //  _signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => dashboard()),
                      );
                    },
                  ),
                ],
              )),
        ]),
        feed(context, _usersStream),
      ],
    ));
  }
}

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
    padding: EdgeInsets.all(5.0),
    child: Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.825,
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
                  hintText: 'Enter a message',
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
              onPressed: () {
                String message = messageTextEditingController.text.trim();

                if (message.isEmpty) {
                  print("Message is empty");
                } else {
                  //new Timestamp.now();

                  FirebaseFirestore.instance.collection('Chats').add({
                    'message': message,
                    'time': new Timestamp.now(),
                    'user': username
                  });
                  messageTextEditingController.clear();
                }
              },
            ),
          ],
        )
      ],
    ),
  );
}

Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
}
