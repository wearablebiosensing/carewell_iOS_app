import 'package:carewellapp/models/initial_assessment.dart';
import 'package:carewellapp/navigation_elements/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

/*
* Initially created by : Shehjar Sadhu
* Date : 2022
*
* */

var TAG = "INITIAL QUESTIONNAIRE/";
var init_ques = new initial_questionnaire();

class init_question_controller extends StatefulWidget {
  var button_text;

  init_question_controller({this.button_text});

  @override
  _init_question_controller createState() {
    return _init_question_controller();
  }
}

/*
* Questionnaire controller class to handle questions navigations.
*/
class _init_question_controller extends State<init_question_controller> {
  // Google sheets API set up.

  var range = init_ques.questions_list.length -
      1; // Gets the length of questions from initial_questionnaire class.
  var _questionNumber = 0; // counter for question number.
  double progress_indicator = 0;
  String _inputAnswer = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size =
        MediaQuery.of(context).size; // Size(411.4, 774.9) for google pixel only
    var deviceTextScaleFactor = MediaQuery.of(context).textScaleFactor;
    // var colors = colors_picker.mainBrandColor;
    var selected = 0;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: size.height * 0.05),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                // The actual question text.
                height: size.height * 0.35,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.1,
                    right: size.width * 0.1,
                  ),
                  child: Center(
                    child: Semantics(
                      label: 'Question ${_questionNumber}',
                      value: ' ${init_ques.questions_list[_questionNumber]}',
                      child: Text(
                        init_ques.questions_list[_questionNumber],
                        maxLines: 10,
                        // you can change it accordingly
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        textScaleFactor: deviceTextScaleFactor,
                        style:
                            TextStyle(fontSize: 41 / deviceTextScaleFactor + 2),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                //Answer input box
                height: 500 * 0.35,
                width: 820,
                child: ListView.builder(
                  padding: EdgeInsets.only(
                      left: 155), // foPadding for left side of Yes button/.
                  scrollDirection: Axis.horizontal,
                  itemCount: init_ques
                      .options[0].length, // Length of Options avaliable.
                  itemBuilder: (context, index) {
                    selected = 0;
                    return Container(
                      height: 80,
                      width: 250,
                      padding: EdgeInsets.all(
                          15), // For padding between the buttons.
                      child: Semantics(
                        value: // Options of initial assessment.
                            '${init_ques.options[_questionNumber][index].toString()}',
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // padding: EdgeInsets.all(12),
                            primary: (init_ques.options[_questionNumber][index]
                                        .toString() ==
                                    _inputAnswer)
                                ? Color(0xFFd9d5d4)
                                : Color(0xFFffffff),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              // set the answer entered by the users
                              _inputAnswer = init_ques.options[_questionNumber]
                                      [index]
                                  .toString();
                              print(
                                  "${TAG} input answer list function: ${_inputAnswer} == ${init_ques.options[_questionNumber][index].toString()}");
                            });
                          },
                          child: ListTile(
                            title: Center(
                              child: Text(
                                // Text for the quesiton options.
                                init_ques.options[_questionNumber][index]
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  // Change the color based on the selected value by the user.
                                  color: init_ques.options[_questionNumber]
                                                  [index]
                                              .toString() ==
                                          _inputAnswer
                                      ? Color(0xFF000000)
                                      : Color(0xFF000000),
                                  fontSize: 50 / deviceTextScaleFactor + 2,
                                  fontFamily: "Nunito",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 300 / 4,
                width: double.maxFinite,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Spacer(),
                    SizedBox(
                      height: 75,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          prevQuestionList(_inputAnswer);
                          for (int i = 0;
                              i < init_ques.options[0].length;
                              i++) {
                            if (init_ques.answers[_questionNumber] ==
                                init_ques.options[0][i]) {
                              setState(() {
                                _inputAnswer = init_ques
                                    .options[_questionNumber][i]
                                    .toString();
                              });
                            }
                          }
                          _inputAnswer =
                              init_ques.answers[_questionNumber].toString();
                          int index = 0;
                          if (init_ques.answers[_questionNumber] ==
                              init_ques.options[0][0]) {
                            index = 0;
                          }
                          if (init_ques.answers[_questionNumber] ==
                              init_ques.options[0][1]) {
                            index = 1;
                          }
                        },
                        child: new Text(
                          "Previous",
                          style: TextStyle(
                              fontSize: 38 / deviceTextScaleFactor + 2),
                        ),
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      height: 75,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          nextQuestionAll(_inputAnswer);
                          if (init_ques.answers[_questionNumber] == "") {
                            _inputAnswer = "";
                          } else {
                            for (int i = 0;
                                i < init_ques.options[0].length;
                                i++) {
                              if (init_ques.answers[_questionNumber] ==
                                  init_ques.options[0][i]) {
                                setState(() {
                                  _inputAnswer = init_ques
                                      .options[_questionNumber][i]
                                      .toString();
                                });
                              }
                            }
                            _inputAnswer =
                                init_ques.answers[_questionNumber].toString();

                            int index = 0;
                            if (init_ques.answers[_questionNumber] ==
                                init_ques.options[0][0]) {
                              index = 0;
                            }
                            if (init_ques.answers[_questionNumber] ==
                                init_ques.options[0][1]) {
                              index = 1;
                            }
                          }
                        },
                        child: new Text(
                          "Next",
                          style: TextStyle(
                              fontSize: 40 / deviceTextScaleFactor + 2),
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                height: 55,
                child: LinearProgressIndicator(
                  value: progress_indicator,
                  // Change this value on click of next button.
                  backgroundColor: Color(0xFF959595),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF62b300)),
                  semanticsLabel: "Question number",
                  semanticsValue: "${_questionNumber}",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

/*
* Function call for navigating back to the previous questions.
* if the 1st question is reached then
* */
  void prevQuestionList(String _currentValue) {
    setState(() {
      init_ques.answers[_questionNumber] = _currentValue;
      // Check to see if we are on the last question.
      if (_questionNumber == 0) {
        print("${TAG} : First question reached.");
        // Go to a screen.
        // Navigator.push(context, new MaterialButton(onPressed: null,))
      } else {
        _questionNumber--;
        // timer_obj.prevQuestionTimer(_questionNumber);
        var range = init_ques.questions_list.length - 1;
        progress_indicator = _questionNumber / range;
      }
    });
  }

/*
* Is called when next button is pressed.
* */
  void nextQuestionAll(String _currentValue) {
    setState(() {
      // - store answers
      print("${TAG} current input value for list view : ${_currentValue}");
      init_ques.answers[_questionNumber] = _currentValue;
      print("${TAG} PD class answers variable : ${init_ques.answers}");
      /* ----------- ----------- ----------- ----------- 
                  TODO: Save this to goofgle sheets
      ----------- ----------- ----------- ----------------  */

      //check to see if there is a next question
      //else finish pro and go to trends
      if (_questionNumber != init_ques.questions_list.length - 1) {
        // timer_obj.nextQuestionTimer(_questionNumber);
        _questionNumber++;
        // timer_obj.nextQuestionTimer(_questionNumber);
        // print("${TAG} Question number : ${_questionNumber.toDouble()} ");
        progress_indicator = _questionNumber / range;
      } else {
        _questionNumber = 0; //Set the questions counter back to 0 .
        //Go to home once the initial questionnaire is done.
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHome1Page("")));
      }
    });
  }
}
