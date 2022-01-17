import 'package:carewellapp/models/initial_assessment.dart';
import 'package:carewellapp/models/questionnaire_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class debug extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => init_question_controller()),
          // );
        },
        child: Text("Click to begin"),
      ),
    ));
  }
}
