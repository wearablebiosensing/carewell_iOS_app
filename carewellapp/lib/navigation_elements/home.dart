import 'package:carewellapp/navigation_elements/community.dart';
import 'package:carewellapp/navigation_elements/dashboard.dart';
import 'package:carewellapp/navigation_elements/debug.dart';
import 'package:carewellapp/navigation_elements/education.dart';
import 'package:carewellapp/navigation_elements/managing_care.dart';
import 'package:carewellapp/navigation_elements/reminders.dart';
import 'package:carewellapp/navigation_elements/troubleshooting.dart';
import 'package:carewellapp/navigation_elements/video_hub.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class MyHome1Page extends StatefulWidget {
  MyHome1Page(this.title);

  final String title;

  @override
  _MyHomePage1State createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHome1Page> {
  int _counter = 0;
  int selectIndex = 0; // Keep track of which page is selected.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(appBarText),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              onPressed: () {
                // do something
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHome1Page("")),
                );
              },
            )
          ],
        ),
        drawer: SideNav(
            // To change the selected index based on the navigation page user is on.
            (int index) {
          // Declarign a function and passing it in the constructor.
          setState(() {
            selectIndex = index;
          });
        }),
        body: Builder(
          builder: (contex) {
            if (selectIndex == 0) {
              return dashboard();
            }
            if (selectIndex == 1) {
              return education();
            }
            if (selectIndex == 2) {
              return managing_care();
            }
            if (selectIndex == 3) {
              return video_hub();
            }
            if (selectIndex == 4) {
              return reminders();
            }
            if (selectIndex == 5) {
              return community();
            }
            if (selectIndex == 6) {
              return troubleshooting();
            }
            if (selectIndex == 7) {
              return debug();
            }
            return Container();
          },
        ));
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
