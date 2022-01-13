import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class video_hub extends StatelessWidget{
  @override
  Widget build(BuildContext contex){
    return  WebView(
      initialUrl: "https://www.youtube.com/watch?v=qq4klEl6BmE&list=PL_bwi5RCnehem7JGuWi6GMDJNe4Pi0F-7",//"https://sites.google.com/uri.edu/care-well-education-ipad2/home",
      javascriptMode: JavascriptMode.unrestricted,
    );


  }

}