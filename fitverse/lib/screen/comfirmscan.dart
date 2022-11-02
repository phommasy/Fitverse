import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitverse/model/attend.dart';
import 'package:fitverse/screen/homemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScanQRcodeComfirm extends StatefulWidget {
  final String qrcoderesult;
  const ScanQRcodeComfirm({Key key, this.qrcoderesult}) : super(key: key);

  @override
  State<ScanQRcodeComfirm> createState() => _ScanQRcodeComfirmState();
}

class _ScanQRcodeComfirmState extends State<ScanQRcodeComfirm> {
  final auth = FirebaseAuth.instance;
  AttendWN myAttend = AttendWN();

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  CollectionReference _myAttendCollection =
      FirebaseFirestore.instance.collection("attend_tb");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Confirmed Attend")),
        body: Builder(builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
                alignment: Alignment.center,
                child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.qrcoderesult,
                          style: const TextStyle(fontSize: 18)),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            QuerySnapshot querySnap = await FirebaseFirestore
                                .instance
                                .collection('reservation_tb')
                                .orderBy('timestamp', descending: false)
                                .where('cid', isEqualTo: widget.qrcoderesult)
                                .where('uid', isEqualTo: auth.currentUser.uid)
                                .get();

                            if (querySnap.docs.length == 0) {
                              Fluttertoast.showToast(
                                  msg: "No data found!",
                                  gravity: ToastGravity.CENTER);
                            } else {
                              QueryDocumentSnapshot doc = querySnap.docs[
                                  0]; // Assumption: the query returns only one document, THE doc you are looking for.
                              DocumentReference docRef = doc.reference;
                              await docRef.delete();

                              await _myAttendCollection.add({
                                "cid": widget.qrcoderesult,
                                "date": DateTime.now(),
                                "email": auth.currentUser.email,
                                "timestamp":
                                    DateTime.now().millisecondsSinceEpoch,
                                "uid": auth.currentUser.uid,
                              });

                              Fluttertoast.showToast(
                                  msg: "Attending successful!",
                                  gravity: ToastGravity.CENTER);
                            }
                          } on FirebaseException catch (e) {
                            String messagealerts;

                            messagealerts = e.message;

                            // print(e.message);
                            //print(e.code);
                            Fluttertoast.showToast(
                                msg: messagealerts,
                                gravity: ToastGravity.CENTER);
                            // print("No Data $e");
                          }

                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return HomeScreen();
                          }));
                        },
                        child: const Text("Confirmed attend!",
                            style: const TextStyle(fontSize: 16)),
                      ),
                    ])),
          );
        }));
  }
}
