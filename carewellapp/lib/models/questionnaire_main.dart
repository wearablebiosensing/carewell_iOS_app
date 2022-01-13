import 'package:carewellapp/models/initial_assessment.dart';
import 'package:carewellapp/navigation_elements/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  var range = init_ques.questions_list.length -
      1; // Gets the length of questions from initial_questionnaire class.
  var _questionNumber = 0; // counter for question number.
  double progress_indicator = 0;
  String _inputAnswer = "";
  // var timer_obj = timer(proList[proTypeSelection].questions_list.length);

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
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  // Answer input box
                  height: size.height * 0.35,
                  width: 150,
                  child: Container(
                    child: ListView.builder(
                      itemCount: init_ques.options[0].length,
                      itemBuilder: (context, index) {
                        selected = 0;
                        var changeColor = false;
                        return SizedBox(
                          height: 150,
                          width: 120,
                          child: Card(
                            color: null,
                            child: Semantics(
                              value:
                                  '${init_ques.options[_questionNumber][index].toString()}',
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(12),
                                  primary: (init_ques.options[_questionNumber]
                                                  [index]
                                              .toString() ==
                                          _inputAnswer)
                                      ? Color(0xFF00bac7)
                                      : Color(0xFFffffff),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _inputAnswer = init_ques
                                        .options[_questionNumber][index]
                                        .toString();
                                    print(
                                        "${TAG} input answer list function: ${_inputAnswer} == ${init_ques.options[_questionNumber][index].toString()}");
                                  });
                                },
                                child: ListTile(
                                  title: Center(
                                    child: Text(
                                      init_ques.options[_questionNumber][index]
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: init_ques
                                                    .options[_questionNumber]
                                                        [index]
                                                    .toString() ==
                                                _inputAnswer
                                            ? Color(0xFF606D9F)
                                            : Color(0xFFFBD491),
                                        fontSize:
                                            20 / deviceTextScaleFactor + 2,
                                        fontFamily: "Nunito",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )),
              SizedBox(
                height: 60 / 4,
                width: double.maxFinite,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Spacer(),
                    SizedBox(
                      height: 60,
                      width: 180,
                      child: ElevatedButton(
                        // style: navButtonStyle,
                        onPressed: () {
                          prevQuestionList(_inputAnswer);
                          //setState(() {
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
                        ),
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      height: 60,
                      width: 180,
                      child: ElevatedButton(
                        // style: navButtonStyle,
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
                                  //nextQuestionAll(_inputAnswer);
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
                          // style: navButtonText,
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Spacer(),
              Expanded(
                child: LinearProgressIndicator(
                  value: progress_indicator,
                  // 0.5, // Change this value on click of next button.
                  backgroundColor: Color(0xFF959595),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFA200)),
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
                  TODO: Save this to goofgle drive
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
            context, MaterialPageRoute(builder: (context) => MyHome1Page()));
      }
    });
  }
}
