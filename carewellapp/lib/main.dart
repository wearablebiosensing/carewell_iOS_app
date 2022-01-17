import 'dart:core';

import 'package:flutter/material.dart';

import 'models/questionnaire_main.dart';
import 'navigation_elements/community.dart';
import 'navigation_elements/dashboard.dart';
import 'navigation_elements/debug.dart';
import 'navigation_elements/education.dart';
import 'navigation_elements/home.dart';
import 'navigation_elements/managing_care.dart';
import 'navigation_elements/reminders.dart';
import 'navigation_elements/troubleshooting.dart';
import 'navigation_elements/video_hub.dart';
import 'package:googleapis/storage/v1.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:gsheets/gsheets.dart';
import 'models/google_sheets.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await googleSheetsAPI.init();
  runApp(MyApp());
}

String appBarText = "CareWell";
const GoogleDriveAPIClientID =
    "887867959629-ke74pgdm06mg9ul66pfuk3b729isslfu.apps.googleusercontent.com";
const _scopes = [ga.DriveApi.driveFileScope];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'CareWell'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int selectIndex = 0; // Keep track of which page is selected.

  @override
  Widget build(BuildContext context) {
    return init_question_controller();
  }
}

/*
* Navigation Drawer class.
* */
class SideNav extends StatelessWidget {
  // int selectedIndex;
  final Function onIndexChanged;

  SideNav(this.onIndexChanged);
  @override
  Widget build(BuildContext contex) {
    Size size =
        MediaQuery.of(contex).size; // Size(411.4, 774.9) for google pixel only
    var deviceTextScaleFactor = MediaQuery.of(contex).textScaleFactor;

    return Drawer(
        child: ListView(
      children: [
        ListTile(
          title: Text("Dashboard",
              style: TextStyle(fontSize: 21 / deviceTextScaleFactor + 2)),
          onTap: () {
            onIndexChanged(0); // Function call.
            appBarText = "Dashboard";
          },
        ),
        Divider(
          color: Colors.black,
        ),
        ListTile(
          title: Text("Education",
              style: TextStyle(fontSize: 21 / deviceTextScaleFactor + 2)),
          onTap: () {
            onIndexChanged(1);
            appBarText = "Education";
          },
        ),
        Divider(
          color: Colors.black,
        ),
        ListTile(
          title: Text("Managing Care",
              style: TextStyle(fontSize: 21 / deviceTextScaleFactor + 2)),
          onTap: () {
            onIndexChanged(2);
            appBarText = "Managing Care";
          },
        ),
        Divider(
          color: Colors.black,
        ),
        ListTile(
          title: Text("Video Hub",
              style: TextStyle(fontSize: 21 / deviceTextScaleFactor + 2)),
          onTap: () {
            onIndexChanged(3);
            appBarText = "Video Hub";
          },
        ),
        Divider(
          color: Colors.black,
        ),
        ListTile(
          title: Text("Reminders",
              style: TextStyle(fontSize: 21 / deviceTextScaleFactor + 2)),
          onTap: () {
            onIndexChanged(4);
            appBarText = "Reminders";
          },
        ),
        Divider(
          color: Colors.black,
        ),
        ListTile(
          title: Text("Community",
              style: TextStyle(fontSize: 21 / deviceTextScaleFactor + 2)),
          onTap: () {
            onIndexChanged(5);
            appBarText = "Community";
          },
        ),
        Divider(
          color: Colors.black,
        ),
        ListTile(
          title: Text("Troubleshooting",
              style: TextStyle(fontSize: 21 / deviceTextScaleFactor + 2)),
          onTap: () {
            onIndexChanged(6);
            appBarText = "Troubleshooting";
          },
        ),
        Divider(
          color: Colors.black,
        ),
        ListTile(
          title: Text("Debug",
              style: TextStyle(fontSize: 21 / deviceTextScaleFactor + 2)),
          onTap: () {
            onIndexChanged(7);
          },
        ),
        Divider(
          color: Colors.black,
        ),
      ],
    ));
  }
}
