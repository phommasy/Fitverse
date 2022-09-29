import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitverse/model/featured.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FeaturedBloc extends ChangeNotifier {
  List<FeaturedModel> _data = [];
  List<FeaturedModel> get data => _data;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future getData() async {
    QuerySnapshot rawData;
    rawData = await firestore
        .collection('ads_banners')
        .orderBy('banner_date', descending: true)
        .limit(5)
        .get();

    List<DocumentSnapshot> _snap = [];
    _snap.addAll(rawData.docs);
    _data = _snap.map((e) => FeaturedModel.fromFirestore(e)).toList();
    notifyListeners();
  }

  onRefresh() {
    _data.clear();
    getData();
    notifyListeners();
  }
}
