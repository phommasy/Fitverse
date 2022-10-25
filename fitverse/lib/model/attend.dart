import 'package:cloud_firestore/cloud_firestore.dart';

class AttendWN {
  String cid;
  String date;
  String email;
  String timestamp;
  String uid;

  AttendWN({this.cid, this.date, this.email, this.timestamp, this.uid});

  factory AttendWN.fromFirestore(DocumentSnapshot snapshot) {
    Map d = snapshot.data() as Map<dynamic, dynamic>;
    return AttendWN(
      cid: d['cid'],
      date: d['date'],
      email: d['email'],
      timestamp: d['timestamp'],
      uid: d['uid'],
    );
  }
}
