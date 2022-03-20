//import 'dart:ffi';

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

List<String> dates = [];
String currentDate =
    DateFormat('EEEE').format(new Timestamp.now().toDate()).toString() +
        ', ' +
        DateFormat('MMMMd').format(new Timestamp.now().toDate()).toString();

StreamBuilder<QuerySnapshot> messageStream(
    Stream<QuerySnapshot<Object?>> _usersStream) {
  // ScrollController listScrollController = ScrollController();
  return StreamBuilder<QuerySnapshot>(
    stream: _usersStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text("Loading");
      }
      /* listScrollController.animateTo(
          listScrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);*/
      // listScrollController.fullScroll(View.FOCUS_DOWN)

      return ListView(
        reverse: true,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

          return Column(
            children: [
              !isInDates(data)
                  ? Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.black54),
                            ),
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.265,
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.16,
                            height: MediaQuery.of(context).size.height * 0.03,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54),
                                borderRadius: BorderRadius.circular(30)),
                            child: DateFormat('EEEE')
                                            .format(data["time"].toDate())
                                            .toString() +
                                        ', ' +
                                        DateFormat('MMMMd')
                                            .format(data["time"].toDate())
                                            .toString() ==
                                    currentDate
                                ? Text("Today")
                                : Text(
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
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.black54),
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
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text(data['likes'].toString())
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.16,
                  ),
                  //  commentStream(getCommentStream(document.id)),
                ],
              ),
            ],
          );
        }).toList(),
      );
    },
  );
}

Column commentStream(Stream<QuerySnapshot<Object?>> _commentStream) {
  return Column(
    children: [
      StreamBuilder<QuerySnapshot>(
        stream: _commentStream,
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
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              return Column(
                children: [
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
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    ],
  );
}

Container feed(
    BuildContext context, Stream<QuerySnapshot<Object?>> _usersStream) {
  TextEditingController messageTextEditingController =
      new TextEditingController();
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width * 0.70,
    padding: EdgeInsets.all(5.0),
    child: SingleChildScrollView(
      // scrollDirection: Axis.vertical,
      // reverse: false,
      //  physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.12,
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
            height: MediaQuery.of(context).size.height * 0.64,
            //height: MediaQuery.of(context).size.height * 0.5,
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
                //  commentStream(_usersStream),
              ]),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.22,
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black54),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    minLines: 1,
                    maxLines: 5, // allow user to enter 5 line in textfield
                    keyboardType: TextInputType
                        .multiline, // user keyboard will have a button to move cursor to next line

                    controller: messageTextEditingController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:
                          isComment ? " Add comment" : ' Type a message ...',
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
                          if (!isComment) {
                            //Map<String, int> likedBy = {};
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
                          } else {
                            FirebaseFirestore.instance
                                .collection(selection)
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

/*
                    FloatingActionButton(
                      child: const Icon(
                        Icons.arrow_right_rounded,
                        size: 50,
                      ),
                      onPressed: () {
                        String message =
                            messageTextEditingController.text.trim();

                        if (message.isEmpty) {
                          print("Message is empty");
                        } else {
                          if (!isComment) {
                            //Map<String, int> likedBy = {};
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
                          } else {
                            FirebaseFirestore.instance
                                .collection(selection)
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
                        dates = [];
                        messageTextEditingController.clear();
                      },
                    ), */
                  ],
                ),
              ],
            ),
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

Stream<QuerySnapshot> getCommentStream(String id) {
  return FirebaseFirestore.instance
      .collection(selection)
      .doc(id)
      .collection("comments")
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
  print("the length of dates is " + dates.length.toString());
  dates.add(date);
  return false;
}

Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
}

bool liked = false;

Widget checkIfLiked(
  String postID,
  Map<String, dynamic> data,
) {
  //List<String> temp = [data["likedBy"][0]];
  if (data["likedBy"].contains(email)) {
    return IconButton(
      icon: new Icon(Icons.thumb_up, color: Colors.green),
      onPressed: () {
        // color:
        dates = [];

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
      },
    );
  }

  return IconButton(
    icon: new Icon(Icons.thumb_up),
    onPressed: () {
      dates = [];

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

      //data["likedBy"].add("Tyler");
    },
  );

  /*FirebaseFirestore.instance
      .collection(selection)
      .doc(postID)
      .get()
      .then((DocumentSnapshot doc) {
    if (doc["likedBy"].contains("lebron")) {
      print(email + " liked this post");
      return IconButton(
        icon: new Icon(Icons.thumb_up, color: Colors.green),
        onPressed: () {
          // color:
          dates = [];

          FirebaseFirestore.instance
              .collection(selection)
              .doc(postID)
              .update({'likes': data['likes'] -= 1});

          List<String> newLikedBy = data["likedBy"];
          newLikedBy.add("lebron");

          FirebaseFirestore.instance
              .collection(selection)
              .doc(postID)
              .update({'likedBy': newLikedBy});

          liked = false;
        },
      );
    }
    print(email + "did not like this post");
  });

  // return IconButton(
  //   icon: new Icon(Icons.thumb_up),
  //   onPressed: () {
  //     dates = [];

  //     FirebaseFirestore.instance
  //         .collection(selection)
  //         .doc(postID)
  //         .update({'likes': data['likes'] += 1});

  //     FirebaseFirestore.instance
  //         .collection(selection)
  //         .doc(postID)
  //         .update({'likedBy': data['likedBy'][email] = 1});

  //     liked = true;
  //   },
  // );
*/
}

/*
IconButton checkIfComment(
  String postID,
  Map<String, dynamic> data,
) {
  if (isComment) {
    print("TRUE");
    return IconButton(
      icon: new Icon(Icons.comment, color: Colors.green),
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
      icon: new Icon(Icons.comment),
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
} */
