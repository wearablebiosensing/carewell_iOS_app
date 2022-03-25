import 'package:carewellapp/Chat%20Application/chatViews/feed_widgets.dart';
import 'package:carewellapp/navigation_elements/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../main.dart';

List<String> messageList = [];

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  ScrollController listScrollController = ScrollController();
  Widget build(BuildContext context) {
    dates = [];

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
                    physics: NeverScrollableScrollPhysics(),
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
                            about = 'Post about general topics.';
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
                            about = 'Post about social topics.';
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
                            about = 'Post about managing care.';
                          });
                        },
                      ),
                      ListTile(
                        title: Text("Care Options - Transitions",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 25 /*/ deviceTextScaleFactor + 2 */)),
                        tileColor: selection == "Care Options / Transitions"
                            ? Colors.blue[900]
                            : Colors.black,
                        onTap: () async {
                          setState(() {
                            isComment = false;
                            selection = "Care Options - Transitions";
                            about = 'Post about Care Options - Transitions.';
                          });
                        },
                      ),
                      ListTile(
                        title: Text("Daily Care",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 25 /*/ deviceTextScaleFactor + 2 */)),
                        tileColor: selection == "Daily Care"
                            ? Colors.blue[900]
                            : Colors.black,
                        onTap: () async {
                          setState(() {
                            isComment = false;
                            selection = "Daily Care";
                            about = 'Post about Daily Care.';
                          });
                        },
                      ),
                      ListTile(
                        title: Text("Family Relationships",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 25 /*/ deviceTextScaleFactor + 2 */)),
                        tileColor: selection == "Family Relationships"
                            ? Colors.blue[900]
                            : Colors.black,
                        onTap: () async {
                          setState(() {
                            isComment = false;
                            selection = "Family Relationships";
                            about = 'Post about Family Relationships.';
                          });
                        },
                      ),
                      ListTile(
                        title: Text("Legal and Financial Planning",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 25 /*/ deviceTextScaleFactor + 2 */)),
                        tileColor: selection == "Legal and Financial Planning"
                            ? Colors.blue[900]
                            : Colors.black,
                        onTap: () async {
                          setState(() {
                            isComment = false;
                            selection = "Legal and Financial Planning";
                            about = 'Post about Legal and Financial Planning.';
                          });
                        },
                      ),
                      ListTile(
                        title: Text("Safety Issues",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 25 /*/ deviceTextScaleFactor + 2 */)),
                        tileColor: selection == "Safety Issues"
                            ? Colors.blue[900]
                            : Colors.black,
                        onTap: () async {
                          setState(() {
                            isComment = false;
                            selection = "Safety Issues";
                            about = 'Post about Safety Issues.';
                          });
                        },
                      ),
                      ListTile(
                        title: Text("Symptoms and Behavior",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 25 /*/ deviceTextScaleFactor + 2 */)),
                        tileColor: selection == "Symptoms and Behavior"
                            ? Colors.blue[900]
                            : Colors.black,
                        onTap: () async {
                          setState(() {
                            isComment = false;
                            selection = "Symptoms and Behavior";
                            about = 'Post about Symptoms and Behavior.';
                          });
                        },
                      ),
                      ListTile(
                        title: Text("Working with a Health Care Team",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 25 /*/ deviceTextScaleFactor + 2 */)),
                        tileColor:
                            selection == "Working with a Health Care Team"
                                ? Colors.blue[900]
                                : Colors.black,
                        onTap: () async {
                          setState(() {
                            isComment = false;
                            selection = "Working with a Health Care Team";
                            about =
                                'Post about Working with a Health Care Team.';
                          });
                        },
                      ),
                      ListTile(
                        title: Text(
                            "General Information about Alzheimer's and dementia",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 25 /*/ deviceTextScaleFactor + 2 */)),
                        tileColor: selection ==
                                "General Information about Alzheimer's and dementia"
                            ? Colors.blue[900]
                            : Colors.black,
                        onTap: () async {
                          setState(() {
                            isComment = false;
                            selection =
                                "General Information about Alzheimer's and dementia";
                            about =
                                "Post about General Information about Alzheimer's and dementia";
                          });
                        },
                      ),
                      ListTile(
                        title: Text("Community Resources",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 25 /*/ deviceTextScaleFactor + 2 */)),
                        tileColor: selection == "Community Resources"
                            ? Colors.blue[900]
                            : Colors.black,
                        onTap: () async {
                          setState(() {
                            isComment = false;
                            selection = "Community Resources";
                            about = 'Post about Community Resources.';
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
        feed(context, getStream(), listScrollController),
      ],
    ));
  }
}
