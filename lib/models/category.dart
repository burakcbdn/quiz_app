import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String category;
  int index;

  Category({this.category,});

  factory Category.fromDoc(DocumentSnapshot doc) {
    return Category(
      category: doc.get("name"),
    );
  }

}