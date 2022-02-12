import 'dart:core';

import 'package:carewellapp/cloud_models/google_sheets_usage_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'cloud_models/google_sheets.dart';

import 'questionnaire/initial_questionnaire_controller.dart';

var deviceID;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await googleSheetsAPI.init();

  runApp(MyApp());
}

String appBarText = "CareWell";

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
  String? _deviceId;

  @override
  Widget build(BuildContext context) {
    // if (isMorning) {
    // If initial questionnaire is not complete

    return init_question_controller();

    // } else {
    //   return Text('Questionnaire Complete.');
    // }
    // return init_question_controller();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String? deviceId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
      deviceID = deviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _deviceId = deviceId;
      print("deviceId->$_deviceId");
    });
  }
}

/*
* Navigation Drawer class.
* */
class SideNav extends StatelessWidget {
  String _inputAnswer = "";
  late Function onIndexChanged;
  SideNav(this.onIndexChanged);

  @override
  Widget build(BuildContext contex) {
    Size size =
        MediaQuery.of(contex).size; // Size(411.4, 774.9) for google pixel only.
    // To resize text beased on device.
    var deviceTextScaleFactor = MediaQuery.of(contex).textScaleFactor;

    return Drawer(
        child: ListView(
      children: [
        ListTile(
          title: Text("Dashboard",
              style: TextStyle(fontSize: 21 / deviceTextScaleFactor + 2)),
          onTap: () async {
            // Record start time
            var startDashboard = DateTime.now().millisecondsSinceEpoch;
            onIndexChanged(0); // Function call.
            appBarText = "Dashboard";
            // Record stop time.
            var stopDashboard = DateTime.now().millisecondsSinceEpoch;
            /* Save Data to Google Sheets. */
            final usage_data_dasboard = {
              // PatientID, StartTimestamp, StopTimestamp, Section
              UsageDataModelGS.PatientID: deviceID,
              UsageDataModelGS.StartTimestamp: startDashboard,
              UsageDataModelGS.StopTimestamp: stopDashboard,
              UsageDataModelGS.Section: appBarText
            };
            await googleSheetsAPI.insertUD([usage_data_dasboard]);
          },
        ),
        Divider(
          color: Colors.black,
        ),
        ListTile(
          title: Text("Education",
              style: TextStyle(fontSize: 21 / deviceTextScaleFactor + 2)),
          onTap: () async {
            var startEducation = DateTime.now().millisecondsSinceEpoch;
            onIndexChanged(1);
            appBarText = "Education";
            var stopEducation = DateTime.now().millisecondsSinceEpoch;
            /* Save Data to Google Sheets. */
            final usage_data_dasboard = {
              // PatientID, StartTimestamp, StopTimestamp, Section
              UsageDataModelGS.PatientID: deviceID,
              UsageDataModelGS.StartTimestamp: startEducation,
              UsageDataModelGS.StopTimestamp: stopEducation,
              UsageDataModelGS.Section: appBarText
            };
            await googleSheetsAPI.insertUD([usage_data_dasboard]);
          },
        ),
        Divider(
          color: Colors.black,
        ),
        ListTile(
          title: Text("Managing Care",
              style: TextStyle(fontSize: 21 / deviceTextScaleFactor + 2)),
          onTap: () async {
            var startManagingCare = DateTime.now().millisecondsSinceEpoch;
            onIndexChanged(2);
            appBarText = "Managing Care";
            var stopManagingCare = DateTime.now().millisecondsSinceEpoch;
            final usage_data_dasboard = {
              UsageDataModelGS.PatientID: deviceID,
              UsageDataModelGS.StartTimestamp: startManagingCare,
              UsageDataModelGS.StopTimestamp: stopManagingCare,
              UsageDataModelGS.Section: appBarText
            };
            await googleSheetsAPI.insertUD([usage_data_dasboard]);
          },
        ),
        Divider(
          color: Colors.black,
        ),
        ListTile(
          title: Text("Video Hub",
              style: TextStyle(fontSize: 21 / deviceTextScaleFactor + 2)),
          onTap: () async {
            var startVideoHub = DateTime.now().millisecondsSinceEpoch;
            onIndexChanged(3);
            appBarText = "Video Hub";
            var stopVideoHub = DateTime.now().millisecondsSinceEpoch;
            final usage_data_dasboard = {
              UsageDataModelGS.PatientID: deviceID,
              UsageDataModelGS.StartTimestamp: startVideoHub,
              UsageDataModelGS.StopTimestamp: stopVideoHub,
              UsageDataModelGS.Section: appBarText
            };
            await googleSheetsAPI.insertUD([usage_data_dasboard]);
          },
        ),
        Divider(
          color: Colors.black,
        ),
        ListTile(
          title: Text("Reminders",
              style: TextStyle(fontSize: 21 / deviceTextScaleFactor + 2)),
          onTap: () async {
            var startReminders = DateTime.now().millisecondsSinceEpoch;
            onIndexChanged(4);
            appBarText = "Reminders";
            var stopReminders = DateTime.now().millisecondsSinceEpoch;
            final usage_data_dasboard = {
              // PatientID, StartTimestamp, StopTimestamp, Section
              UsageDataModelGS.PatientID: deviceID,
              UsageDataModelGS.StartTimestamp: startReminders,
              UsageDataModelGS.StopTimestamp: stopReminders,
              UsageDataModelGS.Section: appBarText
            };
            await googleSheetsAPI.insertUD([usage_data_dasboard]);
          },
        ),
        Divider(
          color: Colors.black,
        ),
        ListTile(
          title: Text("Community",
              style: TextStyle(fontSize: 21 / deviceTextScaleFactor + 2)),
          onTap: () async {
            var startCommunity = DateTime.now().millisecondsSinceEpoch;
            onIndexChanged(5);
            appBarText = "Community";
            var stopCommunity = DateTime.now().millisecondsSinceEpoch;
            final usage_data_dasboard = {
              // PatientID, StartTimestamp, StopTimestamp, Section
              UsageDataModelGS.PatientID: deviceID,
              UsageDataModelGS.StartTimestamp: startCommunity,
              UsageDataModelGS.StopTimestamp: stopCommunity,
              UsageDataModelGS.Section: appBarText
            };
            await googleSheetsAPI.insertUD([usage_data_dasboard]);
          },
        ),
        Divider(
          color: Colors.black,
        ),
        ListTile(
          title: Text("Troubleshooting",
              style: TextStyle(fontSize: 21 / deviceTextScaleFactor + 2)),
          onTap: () async {
            var startTroubleshooting = DateTime.now().millisecondsSinceEpoch;
            onIndexChanged(6);
            appBarText = "Troubleshooting";
            var stopTroubleshooting = DateTime.now().millisecondsSinceEpoch;
            final usage_data_dasboard = {
              // PatientID, StartTimestamp, StopTimestamp, Section
              UsageDataModelGS.PatientID: deviceID,
              UsageDataModelGS.StartTimestamp: startTroubleshooting,
              UsageDataModelGS.StopTimestamp: stopTroubleshooting,
              UsageDataModelGS.Section: appBarText
            };
            await googleSheetsAPI.insertUD([usage_data_dasboard]);
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
