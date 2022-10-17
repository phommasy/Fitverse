import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitverse/components/articlebodyhtmlwidget.dart';
import 'package:fitverse/components/cached_image.dart';
import 'package:fitverse/components/nextpagesapp.dart';
import 'package:fitverse/components/viewsarticledetail.dart';
import 'package:fitverse/model/reservation.dart';
import 'package:fitverse/screen/bookingnow.dart';
import 'package:fitverse/screen/homemenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ArticleBookingDetail extends StatefulWidget {
  final Reservation data;
  final String tag;
  const ArticleBookingDetail({Key key, this.data, this.tag}) : super(key: key);

  @override
  State<ArticleBookingDetail> createState() => _ArticleBookingDetailState();
}

class _ArticleBookingDetailState extends State<ArticleBookingDetail> {
  Reservation myReservation = Reservation();

  final _dbreservation = FirebaseFirestore.instance;

  double rightpadding = 140;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      setState(() {
        rightpadding = 10;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sb = FirebaseAuth.instance;
    final Reservation article = widget.data;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: true,
        top: false,
        maintainBottomViewPadding: true,
        child: Column(children: [
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                _customArticleImageAppBar(article, context),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.deepOrangeAccent,
                                  ),
                                  child: AnimatedPadding(
                                    duration: Duration(milliseconds: 1000),
                                    padding: EdgeInsets.only(
                                        left: 10,
                                        right: rightpadding,
                                        top: 5,
                                        bottom: 5),
                                    child: Text(
                                      article.category,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.time_solid,
                                    size: 18, color: Colors.grey),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Reservation date",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 124, 41, 3),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  article.rsdate,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 124, 41, 3),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(CupertinoIcons.time_solid,
                                    size: 18, color: Colors.grey),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Reservation Time",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 124, 41, 3),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  article.starttiem,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 124, 41, 3),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              article.title,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.6,
                                  wordSpacing: 1),
                            ),
                            Divider(
                              color: Theme.of(context).primaryColor,
                              endIndent: 200,
                              thickness: 2,
                              height: 20,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Reservation remark",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 124, 41, 3),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            ArticleBodyWidgetHtml(
                              htmlData: article.rsdetail,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Wellness detail",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 124, 41, 3),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                            Divider(
                              color: Theme.of(context).primaryColor,
                              endIndent: 200,
                              thickness: 2,
                              height: 20,
                            ),
                            ArticleBodyWidgetHtml(
                              htmlData: article.detail,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              color: Theme.of(context).primaryColor,
                              endIndent: 0,
                              thickness: 2,
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                child: Text(
                                  "Cancel This Reservation",
                                  style: TextStyle(fontSize: 18),
                                ),
                                onPressed: () {
                                  DeleteDataDialogpage(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void DeleteDataDialogpage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Would you like to cancel this reservation?'),
            actions: [
              TextButton(
                child: Text('No'),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: () async {
                  final Reservation deletebooking = widget.data;

                  QuerySnapshot querySnap = await FirebaseFirestore.instance
                      .collection('reservation_tb')
                      .where('timestamp', isEqualTo: deletebooking.timestamp)
                      .get();
                  QueryDocumentSnapshot doc = querySnap.docs[
                      0]; // Assumption: the query returns only one document, THE doc you are looking for.
                  DocumentReference docRef = doc.reference;
                  await docRef.delete();

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }));
                },
              )
            ],
          );
        });
  }

  SliverAppBar _customArticleImageAppBar(
      Reservation article, BuildContext context) {
    return SliverAppBar(
      expandedHeight: 270,
      flexibleSpace: FlexibleSpaceBar(
          background: widget.tag == null
              ? CustomCacheImage(imageUrl: article.image, radius: 0.0)
              : Hero(
                  tag: widget.tag,
                  child: CustomCacheImage(imageUrl: article.image, radius: 0.0),
                )),
      leading: IconButton(
        icon: const Icon(Icons.keyboard_backspace,
            size: 22, color: Colors.deepOrange),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
