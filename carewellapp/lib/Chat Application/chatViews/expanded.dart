import 'package:carewellapp/Chat%20Application/chatViews/feed.dart';
import 'package:carewellapp/navigation_elements/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../main.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                  //color: Colors.black,
                  height: MediaQuery.of(context).size.height, // * 0.923,
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: ListView(
                    children: [
                      Container(
                        height: 25,
                        color: Colors.black,
                      ),
                      Container(
                        height: 50,
                        child: ListTile(
                          title: Text("Chat Topics",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      40 /*/ deviceTextScaleFactor + 2*/)),
                          tileColor: Colors.black,
                        ),
                      ),
                      Container(
                        height: 25,
                        color: Colors.black,
                      ),
                      ListTile(
                        title: Text("General",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 25 /*/ deviceTextScaleFactor + 2*/)),
                        tileColor: selection == "General"
                            ? Colors.blue[900]
                            : Colors.black,
                        onTap: () async {
                          setState(() {
                            isComment = false;
                            selection = "General";
                          });
                        },
                      ),
                      ListTile(
                        title: Text("Social",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize:
                                    25 /* /  deviceTextScaleFactor + 2 */)),
                        tileColor: selection == "Social"
                            ? Colors.blue[900]
                            : Colors.black,
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
                                fontSize: 25 /*/ deviceTextScaleFactor + 2 */)),
                        tileColor: selection == "Managing Care"
                            ? Colors.blue[900]
                            : Colors.black,
                        onTap: () async {
                          setState(() {
                            isComment = false;
                            selection = "Managing Care";
                          });
                        },
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        color: Colors.black,
                      ),
                    ],
                  )),
            ]),
          ),
        ),
        feed(context, getStream()),
      ],
    ));
  }
}
