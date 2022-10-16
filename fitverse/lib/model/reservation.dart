import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation {
  String cid;
  String email;
  String rsdate;
  String rsdetail;
  String uid;
  String title;
  int timestamp;
  String image;
  String detail;
  String category;
  String starttiem;

  Reservation(
      {this.cid,
      this.email,
      this.rsdate,
      this.rsdetail,
      this.uid,
      this.title,
      this.timestamp,
      this.image,
      this.detail,
      this.category,
      this.starttiem});

  factory Reservation.fromFirestore(DocumentSnapshot snapshot) {
    Map d = snapshot.data() as Map<dynamic, dynamic>;
    return Reservation(
      cid: d['cid'],
      email: d['email'],
      rsdate: d['rsdate'],
      rsdetail: d['rsdetail'],
      uid: d['uid'],
      title: d['title'],
      timestamp: d['timestamp'],
      image: d['image'],
      detail: d['detail'],
      category: d['category'],
      starttiem: d['starttiem'],
    );
  }
}
