import 'package:carewellapp/Chat%20Application/chatViews/feed.dart';
import 'package:carewellapp/navigation_elements/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../main.dart';

class Comments extends StatefulWidget {
  const Comments({Key? key}) : super(key: key);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
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
                        isComment = false;
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
                        isComment = false;
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
                        isComment = false;
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
                    onTap: () async {
                      isComment = false;
                    },
                  ),
                  ListTile(
                    title: Text("Sign Out",
                        style: TextStyle(
                            color: Colors.red[900],
                            fontSize: 15 /*/ deviceTextScaleFactor + 2 */)),
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
