import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/category.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/networking/firebase_operations.dart';
import 'package:quiz_app/pages/result_page.dart';
import 'package:quiz_app/widgets/question_widget.dart';


class Questions extends StatefulWidget {
  final Category category;

  const Questions({Key key, this.category}) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  List<Question> questions;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getQuestions(widget.category.category).then((value){
      setState(() {
        questions = value;
        startTimer();
      });
    });

  }

  Timer timer;
  int timeRemaining = 60;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (timeRemaining == 0) {
          timer.cancel();
          Route route = MaterialPageRoute(builder: (context) => ResultPage(questions: questions,));
          Navigator.pushReplacement(context, route);
          currentQuestion = 0;
        } else {
          timeRemaining--;
        }
      });
    });
  }

  int currentQuestion = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff0052D4), Color(0xFF4364F7)]),
        ),
        child: questions != null ? Container(

          child: Column(
            children: [
              Expanded(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentQuestion = index;
                    });
                  },
                  children: questions.map((question) {
                    return QuestionItem(question: question,);
                  }).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  currentQuestion != 0 ? Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: CupertinoButton(
                      onPressed: () {
                        pageController.previousPage(duration: Duration(milliseconds: 200),curve: Curves.easeOutBack);
                      },
                      minSize: 0,
                      padding: EdgeInsets.zero,
                      child: Container(
                        height: 75,
                        width: 75,
                        decoration:
                        BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                        child: Center(
                          child: Icon(Icons.chevron_left_outlined, color: Colors.white,size: 45,),
                        ),
                      ),
                    ),
                  ) : Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Container(
                      height: 75,
                      width: 75,
                      color: Colors.transparent,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only( bottom: 10),
                    child: Container(
                      height: 75,
                      width: 75,
                      decoration:
                      BoxDecoration(shape: BoxShape.circle, color: timeRemaining > 5 ? Colors.green : Colors.red),
                      child: Center(
                        child: Text("$timeRemaining", style: TextStyle(color: Colors.white ,fontSize: 25),),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only( bottom: 10),
                    child: CupertinoButton(
                      onPressed: () {
                        if (currentQuestion == questions.length -1) {

                          Route route = MaterialPageRoute(builder: (context) => ResultPage(questions: questions,));
                          Navigator.pushReplacement(context, route);
                          currentQuestion = 0;
                          timer.cancel();
                        }
                        pageController.nextPage(duration: Duration(milliseconds: 200),curve: Curves.easeOut);
                      },
                      minSize: 0,
                      padding: EdgeInsets.zero,
                      child: Container(
                        height: 75,
                        width: 75,
                        decoration:
                        BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                        child: Center(
                          child: Icon(currentQuestion != questions.length -1 ? Icons.chevron_right_outlined : Icons.check, color: Colors.white,size: 45,),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,),
            ],
          ),

        ) : Container(),
      ),
    );
  }
}
