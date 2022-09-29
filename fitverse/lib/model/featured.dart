// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class FeaturedModel {
  // ignore: non_constant_identifier_names
  String banner_title;
  String banner_pic;
  String banner_date;

  FeaturedModel({this.banner_title, this.banner_pic, this.banner_date});

  factory FeaturedModel.fromFirestore(DocumentSnapshot snapshot) {
    Map d = snapshot.data() as Map<dynamic, dynamic>;
    return FeaturedModel(
      banner_title: d['banner_title'],
      banner_pic: d['banner_pic'],
      banner_date: d['banner_date'],
    );
  }
}
