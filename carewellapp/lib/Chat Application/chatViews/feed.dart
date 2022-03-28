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

    List<String> channelNames = [
      "General",
      "Social",
      "Managing Care",
      "Care Options - Transitions",
      "Daily Care",
      "Family Relationships",
      "Legal and Finacial Planning",
      "Safety Isuues",
      "Symptoms and Behavior",
      "Working with a Heal Care Team",
      "General Information about Alzheimer's and Dementia",
      "Community Resources"
    ];
    List<ListTile> channels = [];

    for (String topic in channelNames) {
      channels.add(ListTile(
        title: Text(topic,
            style: TextStyle(
                color: Colors.white70,
                fontSize: 25 /*/ deviceTextScaleFactor + 2*/)),
        tileColor: selection == topic ? Colors.blue[900] : Colors.black,
        onTap: () async {
          setState(() {
            isComment = false;
            selection = topic;
            about = "Post about " + topic + " topics.";
          });
        },
      ));
    }

    return Scaffold(
        body: Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                height: 25,
                color: Colors.black,
              ),
              Container(
                color: Colors.black,
                height: 50,
                child: ListTile(
                  title: Text("Chat Topics",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40 /*/ deviceTextScaleFactor + 2*/)),
                  //  tileColor: Colors.black,
                ),
              ),
              Container(
                height: 25,
                color: Colors.black,
              ),
              //   SingleChildScrollView(
              Column(children: [
                Container(
                    color: Colors.black,
                    height: MediaQuery.of(context).size.height, // * 0.923,
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: ListView(
                      // physics: NeverScrollableScrollPhysics(),
                      children: [
                        SingleChildScrollView(
                          // physics: ScrollPhysics(),
                          // physics: NeverScrollableScrollPhysics(),

                          child: Container(
                              height: MediaQuery.of(context).size.height *
                                  0.7, // * 0.923,
                              //width: MediaQuery.of(context).size.width * 0.30,
                              child: ListView.builder(
                                  //  physics: NeverScrollableScrollPhysics(),
                                  itemCount: channels.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return channels[index];
                                  })),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          color: Colors.black,
                        ),
                      ],
                    )),
              ]),
              // ),
            ],
          ),
        ),
        feed(context, getStream(), listScrollController),
      ],
    ));
  }
}
