import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  String category;
  String title;
  String detail;
  String image;
  String date;
  int views;

  Article({
    this.category,
    this.title,
    this.detail,
    this.image,
    this.date,
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
      views: d['views'] ?? null,
    );
  }
}
