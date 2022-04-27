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
    List<Channel> channelNames = [
      Channel("Care Options-Transitions",
          'Comments/questions about different care settings (adult day, assisted living, nursing home) or other care transitions'),
      Channel("Daily Care",
          'Comments/questions about struggles with daily care or tips, strategies, or effective approaches'),
      Channel("Family Relationships",
          'Comments/questions about how dementia and caregiver impacts families'),
      Channel("Legal and Financial Planning",
          'Comments/questions about legal or financial issues'),
      Channel("Symptoms and Behavior",
          'Comments/questions about symptoms or behavior problems in the care recipient, including management tips'),
      Channel("Working with a Health Care Team",
          'Comments/questions about experiencing working with health care related to dementia treatment'),
      Channel("Community Resources",
          'Comments/questions about resources available in the community, including those you have found helpful'),
      Channel("General",
          "Comments/questions about Alzheimer's disease or dementia or questions that do not fall into other categories"),
    ];
    // List<ListTile> channels = [];
    List<Container> channels = [];
    for (Channel topic in channelNames) {
      channels.add(Container(
        color: selection == topic.name ? Colors.blue[900] : Colors.black,
        child: ListTile(
          title: Text(topic.name,
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 25 /*/ deviceTextScaleFactor + 2*/)),
          //   selectedTileColor: Colors.blue[900],
          //   tileColor: selection == topic.name ? Colors.blue[900] : Colors.black,
          onTap: () async {
            setState(() {
              isComment = false;
              selection = topic.name;
              about = topic.about;
            });
          },
        ),
      ));
    }

    return Scaffold(
        body: Row(
      children: [
        /*SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(), //ScrollPhysics(),
          //  child: */
        Expanded(
          child: Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.29,
            child: Column(
              children: [
                Container(
                  color: Colors.black,
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                    bottom: MediaQuery.of(context).size.height * 0.02,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.10,
                  child: ListTile(
                    title: Text("Chat Topics",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40)),
                  ),
                ),
                SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Container(
                    //height: MediaQuery.of(context).size.height * 0.85,
                    child: ListView.separated(
                        physics: AlwaysScrollableScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                              color: Colors.black,
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                        itemCount: channels.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return channels[index];
                        }),
                  ),
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

class Channel {
  String name = '';
  String about = '';
  Channel(this.name, this.about);
}
