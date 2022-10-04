import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  String category;
  String title;
  String detail;
  String image;
  String date;
  String openhour;
  String cid;
  int views;

  Article({
    this.category,
    this.title,
    this.detail,
    this.image,
    this.date,
    this.openhour,
    this.cid,
    this.views,
  });

  factory Article.fromFirestore(DocumentSnapshot snapshot) {
    Map d = snapshot.data() as Map<dynamic, dynamic>;
    return Article(
      category: d['category'],
      title: d['title'],
      detail: d['detail'],
      image: d['image'],
      date: d['date'],
      openhour: d['openhour'],
      cid: d['cid'],
      views: d['views'] ?? null,
    );
  }
}
