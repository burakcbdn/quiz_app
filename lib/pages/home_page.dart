import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/category.dart';
import 'package:quiz_app/networking/firebase_operations.dart';
import 'package:quiz_app/networking/sign_in.dart';
import 'package:quiz_app/pages/categories_page.dart';
import 'package:quiz_app/pages/questions_page.dart';

import 'login_page.dart';
import 'market.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category> categories;



  @override
  void initState() {
    super.initState();


  }

  User currentUser = FirebaseAuth.instance.currentUser;

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
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Merhaba,",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                          Text(
                            "${currentUser.displayName}",
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      IconButton(
                        onPressed: () {
                          signOutGoogle().then((value) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          });
                        },
                        icon: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        iconSize: 30,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Kategorini seç ve soruları çözüp puanları toplamaya başla",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                      child: Text(
                    "Toplam puanın",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("users")
                        .doc(currentUser.uid)
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }

                      Map<String, dynamic> data = snapshot.data.data();

                      int point = data["point"];

                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "$point/100",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            CupertinoButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MarketPage(
                                              points: point,
                                            )));
                              },
                              minSize: 0,
                              padding: EdgeInsets.all(10),
                              child: Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Puanlarını harca!",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            CupertinoButton(
                minSize: 0,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
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
                      child: Text(
                        "Katgorileri gör",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Categories()));
                }),

              Expanded(
                flex: 2,
              child: SizedBox(),
            ),
           
          ],
        ),
      ),
    );
  }
}
