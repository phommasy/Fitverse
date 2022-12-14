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
  String address;
  String starttiem;
  String endtimef;

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
      this.address,
      this.category,
      this.starttiem,
      this.endtimef});

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
      address: d['address'],
      category: d['category'],
      starttiem: d['starttiem'],
      endtimef: d['endtimef'],
    );
  }
}
