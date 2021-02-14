import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';


class QuestionItem extends StatefulWidget {
  final Question question;

  const QuestionItem({Key key, this.question}) : super(key: key);

  @override
  _QuestionItemState createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  String selectedAnswer = "";

  @override
  void initState() {
    super.initState();
    selectedAnswer = widget.question.selectedAnswer;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              height: 170,
              width: double.infinity,
              child: Center(
                child: Text(
                  widget.question.question,
                  style: TextStyle(fontSize: 20),
                  softWrap: true,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: widget.question.answers.keys.map((answer) {
              return CupertinoButton(
                onPressed: () {
                  setState(() {
                    selectedAnswer = answer;
                    widget.question.selectedAnswer = answer;
                  });
                },
                minSize: 0,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: selectedAnswer == answer
                        ? Color(0xFF47B347)
                        : Color(0xFF2776FF),
                    borderRadius: BorderRadius.circular(27.5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            color: selectedAnswer == answer
                                ? Color(0xFF2C852C)
                                : Color(0xFF1A51AF),
                            shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            answer,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.question.answers[answer],
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
