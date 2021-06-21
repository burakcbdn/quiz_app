import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/category.dart';
import 'package:quiz_app/networking/firebase_operations.dart';
import 'package:quiz_app/networking/sign_in.dart';
import 'package:quiz_app/pages/questions_page.dart';

class Categories extends StatefulWidget {
  const Categories({Key key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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
    getCategories().then((value) {
      setState(() {
        categories = value;
      });
    });
    super.initState();

    stream = FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseAuth.currentUser.uid)
        .snapshots();
  }

  var inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(40));

  String categoryFilter = "";

  List favs = [];

  Stream<DocumentSnapshot> stream;

  bool showFavs = false;

  @override
  Widget build(BuildContext context) {
    int gradientIndex = -1;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {
            if (showFavs) {
              setState(() {
                showFavs = false;
              });
            } else {
              Navigator.pop(context);
            }
          }, icon: Icon(Icons.chevron_left)),
          backgroundColor: Color(0xff0052D4),
          title: Text(showFavs ? "Favori Kategoriler" : "Kategoriler"),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    showFavs = !showFavs;
                  });
                },
                icon: Icon(showFavs ? Icons.favorite :Icons.favorite_border_outlined))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xff0052D4), Color(0xFF4364F7)]),
            ),
            child: Column(children: [
              SizedBox(
                height: 25,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextField(
                  onChanged: (str) {
                    setState(() {
                      categoryFilter = str;
                    });
                  },
                  
                  
                  style:TextStyle(color: Colors.white, fontSize:18),
                  decoration: InputDecoration(
                    hintText: "Ara",
                    hintStyle: TextStyle(color: Colors.grey),
                
                    suffixIcon: Icon(Icons.search, color: Colors.white),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical:12),
                    border: inputBorder,
                    errorBorder: inputBorder,
                    enabledBorder: inputBorder,
                    focusedBorder: inputBorder,
                    disabledBorder: inputBorder,
                  ),
                ),
              ),
              categories != null
                  ? StreamBuilder(
                      stream: stream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        }

                        gradientIndex = -1;

                        var data = snapshot.data.data();

                        var favorites = data["favorites"];

                        favs = favorites;

                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          child: GridView.count(
                            crossAxisCount: 2,
                            scrollDirection: Axis.horizontal,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                            childAspectRatio: 1,
                            padding: EdgeInsets.zero,
                            children: categories.where((cat) {
                              if (showFavs) {
                                return cat.category.toLowerCase().contains(
                                        categoryFilter.toLowerCase()) &&
                                    favs.contains(cat.category);
                              }
                              return cat.category
                                  .toLowerCase()
                                  .contains(categoryFilter.toLowerCase());
                            }).map((e) {
                              gradientIndex++;

                              bool isFav = favorites.contains(e.category);
                              return CupertinoButton(
                                key: Key(e.category),
                                onPressed: () {
                                  Route route = MaterialPageRoute(
                                      builder: (context) => Questions(
                                            category: e,
                                          ));

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
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: IconButton(
                                            onPressed: () async {
                                              if (isFav)  {
                                                await removeFromFavs(e.category);
                                              } else {
                                                await addToFavs(e.category);
                                              }
                                            },
                                            icon: Icon(Icons.favorite,
                                                color: isFav
                                                    ? Colors.red
                                                    : Colors.white),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            e.category,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 23),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      })
                  : Center(
                      child: CircularProgressIndicator(),
                    )
            ]),
          ),
        ));
  }
}
