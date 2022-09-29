import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String cat_name;
  String cat_pic;
  String cat_date;

  CategoryModel({this.cat_name, this.cat_pic, this.cat_date});

  factory CategoryModel.fromFirestore(DocumentSnapshot snapshot) {
    Map d = snapshot.data() as Map<dynamic, dynamic>;
    return CategoryModel(
      cat_name: d['cat_name'],
      cat_pic: d['cat_pic'],
      cat_date: d['cat_date'],
    );
  }
}
