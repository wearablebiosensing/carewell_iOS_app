import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class education extends StatelessWidget{
  @override
  Widget build(BuildContext contex){
    return WebView(
      initialUrl: "https://sites.google.com/view/carewell/home",//"https://sites.google.com/uri.edu/care-well-education-ipad2/home",
      javascriptMode: JavascriptMode.unrestricted,
    );
    //   Container(
    //     child:Center(child: Text("Education"))
    // );
  }
}