import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/networking/firebase_operations.dart';

import 'categories_page.dart';


class ResultPage extends StatefulWidget {
  final List<Question> questions;


  const ResultPage({Key key, this.questions}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int point = 0;

  @override
  void initState() {
    super.initState();

    widget.questions.forEach((q) {
      if (q.selectedAnswer.toLowerCase() == q.correctAnswer.toLowerCase()) {
        print("correct");
        userAnsweredQuestion(q).then((answered) {
          if (!answered) {
            setState(() {
              point += 5;
              addPointToUser(point);
            });
            markQuestionAsAnswered(q);
          }
        });
      }
    });



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff0052D4), Color(0xFF4364F7)]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: 60,
              ),
            ),
            Text(
              "${widget.questions[0].category} kategorisinde 25 puan üzerinden",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              "$point",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 70,
                  fontWeight: FontWeight.bold),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "puan topladın",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
            Expanded(
              child: SizedBox(
                height: 30,
              ),
            ),
            Text(
              "Tam puanı toplamak için soruları tekrar çözebilirsin",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "unutma, sadece daha önce doğru cevaplamadığın sorular için puan alabilirsin.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(child: SizedBox(),),
            CupertinoButton(
              onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CategoriesPage()));
              },
              minSize: 0,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                elevation: 4,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xff0052D4), Color(0xFF4364F7)]),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text("Çözmeye devam et!", style: TextStyle(color: Colors.white, fontSize: 20),),
                  ),
                ),
              ),
            ),
            SizedBox(height: 150,)
          ],
        ),
      ),
    );
  }
}
