import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/pages/home_page.dart';

import 'networking/sign_in.dart';
import 'pages/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp();
  runApp(QuizApp());
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  bool signedIn;

  @override
  void initState() {
    super.initState();

    isSignedIn().then((value) {
      setState(() {
        signedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "quiz app",
      home: signedIn != null
          ? signedIn
              ? HomePage()
              : LoginPage()
          : Container(),
    );
  }
}
