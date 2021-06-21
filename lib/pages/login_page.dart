import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/networking/sign_in.dart';

import 'home_page.dart';


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
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
              flex: 5,
              child: SizedBox(),
            ),
            Text(
              "HOŞ GELDİN",
              style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(),
            ),
            Text(
              "CET301 Bilgi yarışmasında soruları cevaplayıp ödüller kazanmaya hazır mısın?",
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold,),
              textAlign: TextAlign.center,
            ),
            Expanded(
              flex: 2,
              child: SizedBox(),
            ),
            Text(
              "soruları cevaplayıp puan kazanmak için giriş yap!",
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Expanded(
              flex: 3,
              child: SizedBox(),
            ),
            CupertinoButton(
              onPressed: () {
                signInWithGoogle().then((value){
                  if (value != null) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                  }
                });
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
                    child: Text("Google ile giriş yap", style: TextStyle(color: Colors.white, fontSize: 20),),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
