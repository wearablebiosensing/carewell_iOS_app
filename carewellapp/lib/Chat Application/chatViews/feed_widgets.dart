import 'package:carewellapp/Chat%20Application/chatViews/feed.dart';
import 'package:carewellapp/Chat%20Application/chatViews/signin.dart';
import 'package:carewellapp/main.dart';
import 'package:carewellapp/navigation_elements/community.dart';
import 'package:carewellapp/navigation_elements/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String selection = 'General';
String post = '';
String about = 'Post about general topics.';
bool isComment = false;

String date = DateFormat('EEEE').format(Timestamp.now().toDate()).toString() +
    ', ' +
    DateFormat('MMMMd').format(Timestamp.now().toDate()).toString();

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

          return Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.black54),
                      ),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.27,
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.16,
                      height: MediaQuery.of(context).size.height * 0.03,
                      //   padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          // ignore: prefer_const_constructors
                          //gradient: LinearGradient(
                          //blue color background
                          //  colors: [Color(0xff007EF4), Color(0xff2A75BC)]),
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        //  Header format below
                        DateFormat('EEEE')
                                .format(data["time"].toDate())
                                .toString() +
                            ', ' +
                            DateFormat('MMMMd')
                                .format(data["time"].toDate())
                                .toString(),

                        //  textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      )),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.black54),
                      ),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.27,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    ' ' + data["user"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    //  Header format below
                    '\n ' +
                        DateFormat('jm')
                            .format(data["time"].toDate())
                            .toString(),
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 10,
                    ),
                  )
                ],
              ),
              ListTile(
                title: Text(data['message']),
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
              ),
              Container(
                //width: MediaQuery.of(context).size.width,
                //padding: EdgeInsets.all(5.0),
                alignment: Alignment.centerRight,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                    Icon(
                      Icons.comment,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                    ),
                    checkIfLiked(document.id, data),
                    /*   IconButton(
                      icon: new Icon(Icons.thumb_up, color: Colors.white),
                      onPressed: () {
                        // color:
                        print("The value of email is: " + email);
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(email)
                            .collection("liked_posts")
                            .add({
                          'postid': document.id,
                        });

                        FirebaseFirestore.instance
                            .collection(selection)
                            .doc(document.id)
                            .update({'likes': data['likes'] += 1});
                      },
                    ), */
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text(data['likes'].toString())
                  ],
                ),
              ),
            ],
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
                      "About : " + about,
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
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
                      // FirebaseFirestore.instance.collection(selection).add({
                      //   'message': message,
                      //   'time': new Timestamp.now(),
                      //   'user': email,
                      //   'likes': 0,
                      // });
                      FirebaseFirestore.instance
                          .collection(selection)
                          .doc("dates")
                          .collection(date)
                          .add({
                        'message': message,
                        'time': new Timestamp.now(),
                        'user': email,
                        'likes': 0,
                      });
                    } else {
                      FirebaseFirestore.instance
                          .collection(selection)
                          .doc(date)
                          .collection(date)
                          .doc(post)
                          .collection("comments")
                          .add({
                        'message': message,
                        'time': new Timestamp.now(),
                        'user': username,
                        'likes': 0,
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
        .doc("dates")
        .collection(date)
        .doc(post)
        .collection("comments")
        .orderBy('time')
        .snapshots();
  }
  return FirebaseFirestore.instance
      .collection(selection)
      .doc("dates")
      .collection(date)
      //.orderBy('time')
      .snapshots();
}

Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
}

bool liked = false;

IconButton checkIfLiked(
  String postID,
  Map<String, dynamic> data,
) {
  print("HERE");

  /* DocumentSnapshot doc = FirebaseFirestore.instance
      .collection('Users')
      .doc(email)
      .collection('liked_posts')
      .where('postid', isEqualTo: postID)
      .get() as DocumentSnapshot; //Future<QuerySnapshot<Map<String, dynamic>>>; */
  //print(doc);
  if (liked) {
    print("TRUE");
    return IconButton(
      icon: new Icon(Icons.thumb_up, color: Colors.green),
      onPressed: () {
        // color:

        FirebaseFirestore.instance
            .collection('Users')
            .doc(email)
            .collection("liked_posts")
            .add({
          'postid': postID,
        });

        FirebaseFirestore.instance
            .collection(selection)
            .doc(postID)
            .update({'likes': data['likes'] -= 1});
        liked = false;
      },
    );
  } else {
    print("False");
    return IconButton(
      icon: new Icon(Icons.thumb_up),
      onPressed: () {
        // color:

        FirebaseFirestore.instance
            .collection('Users')
            .doc(email)
            .collection("liked_posts")
            .add({
          'postid': postID,
        });

        FirebaseFirestore.instance
            .collection(selection)
            .doc(postID)
            .update({'likes': data['likes'] += 1});
        liked = true;
      },
    );
  }
}
