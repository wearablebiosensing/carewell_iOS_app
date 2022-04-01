// ignore_for_file: dead_code

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
      //  "Legal and Finacial Planning",
      //  "Safety Isuues",
      //  "Symptoms and Behavior",
      //  "Working with a Heal Care Team",
      //  "General Information about Alzheimer's and Dementia",
      //  "Community Resources"
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
/*
    return Scaffold(
        body: Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                color: Colors.black,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Text("Chat Topics",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40)),
              ),

              // ),
              SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Expanded(
                  child: Container(
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: channels.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return channels[index];
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
        feed(context, getStream(), listScrollController),
      ],
    ));
  }
} */

    return Scaffold(
        body: Row(
      children: [
        SingleChildScrollView(
          physics: ScrollPhysics(),
          //  child: Expanded(
          child: Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.29,
            child: Column(
              children: [
                Container(
                  color: Colors.black,
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.015,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: ListTile(
                    title: Text("Chat Topics",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40)),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: ListView.separated(
                      physics: AlwaysScrollableScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height * 0.001,
                          ),
                      itemCount: channels.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return channels[index];
                      }),
                ),
              ],
            ),
          ),
          // ),
        ),
        feed(context, getStream(), listScrollController),
      ],
    ));
  }
}
/*


body: SingleChildScrollView( // The relevant error-causing widget
    child: Column(
      children: [
        for (int i = 0; i < 100; i++)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [...],
              ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: 100,
              itemBuilder: (BuildContext context, int index) {...},
          ),
      ],
    ),
  ),
); */