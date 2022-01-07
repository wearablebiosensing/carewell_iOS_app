import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class managing_care extends StatelessWidget{
  @override
  Widget build(BuildContext contex){
    return WebView(
      initialUrl: "https://sites.google.com/view/managingcare-cw/home",//"https://sites.google.com/uri.edu/care-well-education-ipad2/home",
      javascriptMode: JavascriptMode.unrestricted,
    );

    //
  }

}