import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  String id;
  String question;
  String category;
  Map<String, dynamic> answers;
  String correctAnswer;
  bool answered;
  String selectedAnswer;

  Question({this.question, this.answers, this.correctAnswer, this.answered,this.selectedAnswer = "", this.id, this.category});

  factory Question.fromDoc(DocumentSnapshot doc) {
    return Question(
      question: doc.get("question"),
      answers: doc.get("answers"),
      answered: doc.get("answered"),
      correctAnswer: doc.get("correctAnswer").replaceAll("\n", ""),
      id: doc.id,
      category: doc.get("category")
    );
  }
}