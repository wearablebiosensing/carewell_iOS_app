import 'package:flutter/material.dart';

import 'navigation_elements/community.dart';
import 'navigation_elements/dashboard.dart';
import 'navigation_elements/debug.dart';
import 'navigation_elements/education.dart';
import 'navigation_elements/home.dart';
import 'navigation_elements/managing_care.dart';
import 'navigation_elements/reminders.dart';
import 'navigation_elements/troubleshooting.dart';
import 'navigation_elements/video_hub.dart';

void main() {
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
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                  MaterialPageRoute(builder: (context) => MyHome1Page()),
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
        //Taken in on changed function as parameter/.

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
    return Drawer(
        child: ListView(
      children: [
        ListTile(
          title: Text("Dashboard", style: TextStyle(fontSize: 21)),
          onTap: () {
            onIndexChanged(0); // Function call.
            appBarText = "Dashboard";
          },
        ),
        Divider(
          color: Colors.black,
        ),
        ListTile(
          title: Text("Education", style: TextStyle(fontSize: 21)),
          onTap: () {
            onIndexChanged(1);
            appBarText = "Education";
          },
        ),
        Divider(
          color: Colors.black,
        ),
        ListTile(
          title: Text("Managing Care", style: TextStyle(fontSize: 21)),
          onTap: () {
            onIndexChanged(2);
            appBarText = "Managing Care";
          },
        ),
        Divider(
          color: Colors.black,
        ),
        ListTile(
          title: Text("Video Hub", style: TextStyle(fontSize: 21)),
          onTap: () {
            onIndexChanged(3);
            appBarText = "Video Hub";
          },
        ),
        Divider(
          color: Colors.black,
        ),
        ListTile(
          title: Text("Reminders", style: TextStyle(fontSize: 21)),
          onTap: () {
            onIndexChanged(4);
            appBarText = "Reminders";
          },
        ),
        Divider(
          color: Colors.black,
        ),
        ListTile(
          title: Text("Community", style: TextStyle(fontSize: 21)),
          onTap: () {
            onIndexChanged(5);
            appBarText = "Community";
          },
        ),
        Divider(
          color: Colors.black,
        ),
        ListTile(
          title: Text("Troubleshooting", style: TextStyle(fontSize: 21)),
          onTap: () {
            onIndexChanged(6);
            appBarText = "Troubleshooting";
          },
        ),
        Divider(
          color: Colors.black,
        ),
        ListTile(
          title: Text("Debug", style: TextStyle(fontSize: 21)),
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
