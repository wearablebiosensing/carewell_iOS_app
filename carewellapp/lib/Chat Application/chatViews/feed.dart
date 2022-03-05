import 'package:carewellapp/Chat%20Application/chatViews/expanded.dart';
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
String post = '';
bool isComment = false;

// class Feed extends StatefulWidget {
//   @override
//   _FeedState createState() => _FeedState();
// }

// class _FeedState extends State<Feed> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(children: [
//                 Container(
//                     //color: Colors.black,
//                     height: MediaQuery.of(context).size.height, // * 0.923,
//                     width: MediaQuery.of(context).size.width * 0.30,
//                     child: ListView(
//                       children: [
//                         Container(
//                           height: 25,
//                           color: Colors.black,
//                         ),
//                         Container(
//                           height: 50,
//                           child: ListTile(
//                             title: Text("Chat Topics",
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize:
//                                         40 /*/ deviceTextScaleFactor + 2*/)),
//                             tileColor: Colors.black,
//                           ),
//                         ),
//                         Container(
//                           height: 25,
//                           color: Colors.black,
//                         ),
//                         ListTile(
//                           title: Text("General",
//                               style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize:
//                                       25 /*/ deviceTextScaleFactor + 2*/)),
//                           tileColor: selection == "General"
//                               ? Colors.blue[900]
//                               : Colors.black,
//                           onTap: () async {
//                             setState(() {
//                               selection = "General";
//                             });
//                           },
//                         ),
//                         ListTile(
//                           title: Text("Social",
//                               style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize:
//                                       25 /* /  deviceTextScaleFactor + 2 */)),
//                           tileColor: selection == "Social"
//                               ? Colors.blue[900]
//                               : Colors.black,
//                           onTap: () async {
//                             setState(() {
//                               selection = "Social";
//                             });
//                           },
//                         ),
//                         ListTile(
//                           title: Text("Managing Care",
//                               style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize:
//                                       25 /*/ deviceTextScaleFactor + 2 */)),
//                           tileColor: selection == "Managing Care"
//                               ? Colors.blue[900]
//                               : Colors.black,
//                           onTap: () async {
//                             setState(() {
//                               selection = "Managing Care";
//                             });
//                           },
//                         ),
//                         Container(
//                           height: MediaQuery.of(context).size.height,
//                           color: Colors.black,
//                         ),
//                       ],
//                     )),
//               ]),
//             ),
//           ),
//           feed(context, getStream()),
//         ],
//       ),
//     );
//   }
// }

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
                MaterialPageRoute(builder: (context) => Feed()),
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
    width: MediaQuery.of(context).size.width * 0.70,

    //padding: EdgeInsets.all(5.0),
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      isComment ? "Comments" : selection,
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      "About : Post about the topic managing care.",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 25, color: Colors.black54),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.73,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(children: [
                Divider(
                  color: Colors.black54,
                ),
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
                onPressed: () {
                  String message = messageTextEditingController.text.trim();

                  if (message.isEmpty) {
                    print("Message is empty");
                  } else {
                    if (!isComment) {
                      FirebaseFirestore.instance.collection(selection).add({
                        'message': message,
                        'time': new Timestamp.now(),
                        'user': username,
                      });
                    } else {
                      FirebaseFirestore.instance
                          .collection(selection)
                          .doc(post)
                          .collection("comments")
                          .add({
                        'message': message,
                        'time': new Timestamp.now(),
                        'user': username,
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
