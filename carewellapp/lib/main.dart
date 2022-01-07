import 'package:flutter/material.dart';

import 'navigation_elements/community.dart';
import 'navigation_elements/dashboard.dart';
import 'navigation_elements/education.dart';
import 'navigation_elements/managing_care.dart';
import 'navigation_elements/reminders.dart';
import 'navigation_elements/troubleshooting.dart';
import 'navigation_elements/video_hub.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'CareWell'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int selectIndex = 0; // Keep track of which page is selected.
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      drawer: SideNav( // To change the selected index based on the navigation page user is on.
          (int index){ // Declarign a function and passing it in the constructor.
            setState(() {
              selectIndex = index;
            });
          }
      ),      //Taken in on changed function as parameter/.

        body: Builder(
        builder: (contex){
          if (selectIndex==0){
            return
              dashboard();
          }
          if (selectIndex==1){
            return
            education();
          }
          if (selectIndex==2){
            return
              managing_care();
          }
          if (selectIndex==3){
            return
              video_hub();
          }
          if (selectIndex==4){
            return
              reminders();
          }
          if (selectIndex==5){
            return
              community();
          }
          if (selectIndex==6){
            return
              troubleshooting();
          }

          return Container();
        },

      )
    );
  }
}
/*
* Navigation Drawer class.
* */
class SideNav extends StatelessWidget{
  // int selectedIndex;
  final Function onIndexChanged;

  SideNav(this.onIndexChanged);
  @override
  Widget build(BuildContext contex){
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text("Dashboard",style: TextStyle(fontSize: 21)),
            onTap: (){
              onIndexChanged(0); // Function call.
            },
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
              title: Text("Education",style: TextStyle(fontSize: 21)),
            onTap: (){
              onIndexChanged(1);
            },
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
              title: Text("Managing Care",style: TextStyle(fontSize: 21)),
            onTap: (){
              onIndexChanged(2);
            },
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
              title: Text("Video Hub",style: TextStyle(fontSize: 21)),
            onTap: (){
              onIndexChanged(3);
            },
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
              title: Text("Reminders",style: TextStyle(fontSize: 21)),
            onTap: (){
              onIndexChanged(4);
            },
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
              title: Text("Community",style: TextStyle(fontSize: 21)),
            onTap: (){
              onIndexChanged(5);
            },
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
              title: Text("Troubleshooting",style: TextStyle(fontSize: 21)),
            onTap: (){
              onIndexChanged(6);
            },
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
              title: Text("Debug",style: TextStyle(fontSize: 21)),
            onTap: (){
              onIndexChanged(7);
            },
          ),
          Divider(
            color: Colors.black,
          ),
        ],
      )
    );
  }
}




