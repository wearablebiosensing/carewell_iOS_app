//import 'dart:ffi';

import 'package:carewellapp/Chat%20Application/chatViews/feed.dart';
import 'package:carewellapp/Chat%20Application/chatViews/signin.dart';
//import 'package:carewellapp/Chat%20Application/chatViews/signup.dart';
import 'package:carewellapp/main.dart';
import 'package:carewellapp/navigation_elements/community.dart';
import 'package:carewellapp/navigation_elements/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//This file displays updates messages/likes/comment feeds
String selection = 'General';
String post = '';
String about =
    "Comments/questions about Alzheimer's disease or dementia or questions that do not fall into other categories";
bool isComment = false;
List<String> dates = [];

//user of the selected post for comments
String currentUser = "";
String currentMessage = "";

String currentDate =
    DateFormat('EEEE').format(new Timestamp.now().toDate()).toString() +
        ', ' +
        DateFormat('MMMMd').format(new Timestamp.now().toDate()).toString();

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
        reverse: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

          messageList.add(data["message"].toString());

          List<Widget> showPosts() {
            return [
              //Checks if we have seen the current date before. If so does not display a new date
              !isInDates(data)
                  ? Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.black12),
                            ),
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.265,
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(3),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.16,
                            height: MediaQuery.of(context).size.height * 0.031,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(30)),
                            //Formats date. If date of message is the current date prints "Today." Else prints date and day.
                            child: DateFormat('EEEE')
                                            .format(data["time"].toDate())
                                            .toString() +
                                        ', ' +
                                        DateFormat('MMMMd')
                                            .format(data["time"].toDate())
                                            .toString() ==
                                    currentDate
                                ? Text(
                                    "Today",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  )
                                : Text(
                                    DateFormat('EEEE')
                                            .format(data["time"].toDate())
                                            .toString() +
                                        ', ' +
                                        DateFormat('MMMMd')
                                            .format(data["time"].toDate())
                                            .toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  )),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.black12),
                            ),
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.265,
                          ),
                        ),
                      ],
                    )
                  : Container(),
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
              ),
              Container(
                  alignment: Alignment.centerRight,
                  child: Row(children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                    ),
                    IconButton(
                      icon: new Icon(Icons.comment),
                      onPressed: () {
                        isComment = true;
                        post = document.id;
                        currentMessage = data['message'];
                        currentUser = data["user"];

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Feed()),
                        );
                      },
                    ),
                    //Displays a different colored thumbs up icon based on if the user has liked the post or not
                    checkIfLiked(document.id, data),
                    Text(data['likes'].toString())
                  ]))
            ];
          }

          //Displays the comment feed
          List<Widget> showComments() {
            return [
              Container(
                color: Colors.grey,
                child: Column(children: [
                  Text('\n'),
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
                            DateFormat('MMMMd')
                                .format(data["time"].toDate())
                                .toString() +
                            " @" +
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
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      child: Row(children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                        ),
                        checkIfLiked(document.id, data),
                        Padding(
                          padding: EdgeInsets.all(3.0),
                        ),
                        Text(data['likes'].toString())
                      ]))
                ]),
              )
            ];
          }

          return SingleChildScrollView(
            // Displays feed based on whether or not the User is viewing comments or the main feed
            child: Column(
              children: !isComment ? showPosts() : showComments(),
            ),
          );
        }).toList(),
      );
    },
  );
}

//The main body of the chat screen
//Looks long, first half is if the user is viewing posts. Second half is if they are viewing comments.
Container feed(
    BuildContext context,
    Stream<QuerySnapshot<Object?>> _usersStream,
    ScrollController listScrollController) {
  TextEditingController messageTextEditingController =
      new TextEditingController();
  return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.70,
      padding: EdgeInsets.all(5.0),
      child: !isComment //If viewing post
          ? SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              selection,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              "About : " + about,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 24, color: Colors.black54),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.60,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        messageStream(_usersStream),
                      ]),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black54),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: TextField(
                            minLines: 1,
                            maxLines:
                                5, // allow user to enter 5 lines in textfield
                            keyboardType: TextInputType
                                .multiline, // user keyboard will have a button to move cursor to next line

                            controller: messageTextEditingController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: isComment
                                  ? " Add comment"
                                  : ' Type a message ...',
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.62,
                            ),
                            GestureDetector(
                              onTap: () async {
                                String message =
                                    messageTextEditingController.text.trim();
                                //Adds inputted message to firebase
                                if (message.isEmpty) {
                                  print("Message is empty");
                                } else {
                                  List<String> likedBy = [];

                                  FirebaseFirestore.instance
                                      .collection(selection)
                                      .add({
                                    'message': message,
                                    'time': new Timestamp.now(),
                                    'user': email,
                                    'likes': 0,
                                    'likedBy': likedBy,
                                  });
                                }
                                dates = [];
                                messageTextEditingController.clear();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.05,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    // ignore: prefer_const_constructors
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text("Post",
                                    style: new TextStyle(
                                        color: Colors.white, fontSize: 14)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          : Scaffold(
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  child: IconButton(
                                    icon: new Icon(Icons.arrow_back,
                                        color: Colors.blue),
                                    onPressed: () {
                                      isComment = false;

                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (c, a1, a2) => Feed(),
                                          transitionsBuilder: (c, anim, a2,
                                                  child) =>
                                              SlideTransition(
                                                  position: anim.drive(Tween(
                                                          begin:
                                                              Offset(-1.0, 0.0),
                                                          end: Offset.zero)
                                                      .chain(CurveTween(
                                                          curve: Curves.ease))),
                                                  child: child),
                                          transitionDuration:
                                              Duration(milliseconds: 500),
                                        ),
                                      ); //Use pageroutebuilder and transitions to make the page come in from the other side
                                    },
                                  ),
                                ),
                              ),
                              Text("Back", style: TextStyle(fontSize: 19)),
                            ],
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(currentUser,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                Container(
                                  padding: EdgeInsets.only(top: 5),
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  child: Expanded(
                                    child: SingleChildScrollView(
                                      child: Text(
                                        currentMessage,
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(color: Colors.black),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Expanded(
                          child: SingleChildScrollView(
                              child: Expanded(
                                  child: messageStream(_usersStream)))),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.17,
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black54),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: TextField(
                              minLines: 1,
                              maxLines:
                                  5, // allow user to enter 5 line in textfield
                              keyboardType: TextInputType
                                  .multiline, // user keyboard will have a button to move cursor to next line

                              controller: messageTextEditingController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: " Add comment",
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.62,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  String message =
                                      messageTextEditingController.text.trim();

                                  if (message.isEmpty) {
                                    print("Message is empty");
                                  } else {
                                    List<String> likedBy = [];

                                    FirebaseFirestore.instance
                                        .collection(selection)
                                        .doc(post)
                                        .collection("comments")
                                        .add({
                                      'message': message,
                                      'time': new Timestamp.now(),
                                      'user': email,
                                      'likes': 0,
                                      'likedBy': likedBy,
                                    });
                                  }
                                  dates = [];
                                  messageTextEditingController.clear();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text("Post",
                                      style: new TextStyle(
                                          color: Colors.white, fontSize: 14)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )));
}

//Fiorebase live update functioons. Searches through a collection to provide a constantly updating "stream" of the data within the collection
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

bool isInDates(Map<String, dynamic> data) {
  String date = DateFormat('EEEE').format(data["time"].toDate()).toString() +
      ', ' +
      DateFormat('MMMMd').format(data["time"].toDate()).toString();

  for (int i = 0; i < dates.length; i++) {
    if (date == dates[i]) {
      return true;
    }
  }
  dates.add(date);
  return false;
}

Widget checkIfLiked(
  String postID,
  Map<String, dynamic> data,
) {
  if (data["likedBy"].contains(email)) {
    return IconButton(
      icon: new Icon(Icons.thumb_up, color: Colors.green),
      onPressed: () {
        dates = [];

        if (!isComment) {
          FirebaseFirestore.instance
              .collection(selection)
              .doc(postID)
              .update({'likes': data['likes'] -= 1});

          List<String> temp = [];
          int len = data["likedBy"].length;

          for (int i = 0; i < len; i++) {
            temp.add(data["likedBy"][i]);
          }

          temp.remove(email);

          FirebaseFirestore.instance
              .collection(selection)
              .doc(postID)
              .update({'likedBy': temp});
        } else {
          FirebaseFirestore.instance
              .collection(selection)
              .doc(post)
              .collection("comments")
              .doc(postID)
              .update({'likes': data['likes'] -= 1});

          List<String> temp = [];
          int len = data["likedBy"].length;

          for (int i = 0; i < len; i++) {
            temp.add(data["likedBy"][i]);
          }

          temp.remove(email);

          FirebaseFirestore.instance
              .collection(selection)
              .doc(post)
              .collection("comments")
              .doc(postID)
              .update({'likedBy': temp});
        }
      },
    );
  }

  return IconButton(
    icon: new Icon(Icons.thumb_up),
    onPressed: () {
      dates = [];

      if (!isComment) {
        FirebaseFirestore.instance
            .collection(selection)
            .doc(postID)
            .update({'likes': data['likes'] += 1});

        List<String> temp = [];
        int len = data["likedBy"].length;

        for (int i = 0; i < len; i++) {
          temp.add(data["likedBy"][i]);
        }

        temp.add(email);

        FirebaseFirestore.instance
            .collection(selection)
            .doc(postID)
            .update({'likedBy': temp});
      } else {
        FirebaseFirestore.instance
            .collection(selection)
            .doc(post)
            .collection("comments")
            .doc(postID)
            .update({'likes': data['likes'] += 1});

        List<String> temp = [];
        int len = data["likedBy"].length;

        for (int i = 0; i < len; i++) {
          temp.add(data["likedBy"][i]);
        }

        temp.add(email);

        FirebaseFirestore.instance
            .collection(selection)
            .doc(post)
            .collection("comments")
            .doc(postID)
            .update({'likedBy': temp});
      }
    },
  );
}
