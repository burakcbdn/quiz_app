import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/category.dart';
import 'package:quiz_app/networking/firebase_operations.dart';
import 'package:quiz_app/networking/sign_in.dart';
import 'package:quiz_app/pages/questions_page.dart';

import 'login_page.dart';
import 'market.dart';


class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<Category> categories;

  List<LinearGradient> gradients = [
    LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xff0052D4), Color(0xFF4364F7)]),
    LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xff799F0C), Color(0xFFACBB78)]),
    LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xff834d9b), Color(0xFFd04ed6)]),
    LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xfffd746c), Color(0xFFff9068)])
  ];


  @override
  void initState() {
    super.initState();

    getCategories().then((value) {
      setState(() {
        categories = value;
      });
    });

  }

  User currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    int gradientIndex = -1;
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
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                          });
                        },
                        icon: Icon(Icons.logout, color: Colors.white,),
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
                    height: 40,
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
                    future: FirebaseFirestore.instance.collection("users").doc(currentUser.uid).get(),
                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

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
                              onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MarketPage(points: point,)));
                              },
                              minSize: 0,
                              padding: EdgeInsets.all(10),
                              child: Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.shopping_cart_outlined, color: Colors.white,),
                                    SizedBox(width: 10,),
                                    Text("Puanlarını harca!", style: TextStyle(color: Colors.white),)
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
            categories != null
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: GridView.count(
                      crossAxisCount: 2,
                      scrollDirection: Axis.horizontal,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      childAspectRatio: 1,
                      padding: EdgeInsets.zero,
                      children: categories.map((e) {
                        gradientIndex++;
                        return CupertinoButton(
                          onPressed: () {

                            Route route = MaterialPageRoute(builder: (context) => Questions(category: e,));

                            Navigator.push(context, route);

                          },
                          minSize: 0,
                          padding: EdgeInsets.all(5),
                          child: Material(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              height: 120,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: gradients[gradientIndex]),
                              child: Center(
                                child: Text(
                                  e.category,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 23),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )
          ],
        ),
      ),
    );
  }
}
