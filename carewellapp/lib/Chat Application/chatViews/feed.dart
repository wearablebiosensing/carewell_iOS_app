import 'package:carewellapp/Chat%20Application/chatViews/signin.dart';
import 'package:carewellapp/main.dart';
import 'package:carewellapp/navigation_elements/community.dart';
import 'package:carewellapp/navigation_elements/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

String selection = 'General';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
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
                      setState(() {
                        selection = "General";
                      });
                    },
                  ),
                  ListTile(
                    title: Text("Social",
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15 /* /  deviceTextScaleFactor + 2 */)),
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
                            fontSize: 15 /*/ deviceTextScaleFactor + 2 */)),
                    onTap: () async {
                      setState(() {
                        selection = "Managing Care";
                      });
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
                    onTap: () async {},
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
        feed(context, getStream()),
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
    //padding: EdgeInsets.all(5.0),
    child: Column(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue[900],
            child: Align(
              alignment: Alignment.center,
              child: Text(
                selection,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(children: [
              messageStream(getStream()),
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
                  FirebaseFirestore.instance.collection(selection).add({
                    'message': message,
                    'time': new Timestamp.now(),
                    'user': username
                  });
                }
                messageTextEditingController.clear();
              },
            ),
          ],
        )
      ],
    ),
  );
}

Stream<QuerySnapshot> getStream() {
  return FirebaseFirestore.instance
      .collection(selection)
      .orderBy('time')
      .snapshots();
}

Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
}
