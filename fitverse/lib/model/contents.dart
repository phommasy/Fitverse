import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  String category;
  String title;
  String detail;
  String image;
  String date;
  String openhour;
  String closehour;
  String address;
  String videolink;
  String videotitle;
  String cid;
  int views;

  Article({
    this.category,
    this.title,
    this.detail,
    this.image,
    this.date,
    this.openhour,
    this.closehour,
    this.address,
    this.videolink,
    this.videotitle,
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
      closehour: d['closehour'],
      address: d['address'],
      videolink: d['videolink'],
      videotitle: d['videotitle'],
      cid: d['cid'],
      views: d['views'] ?? null,
    );
  }
}
