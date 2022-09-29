import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TabIndexBlocHome extends ChangeNotifier {
  int _tabIndexHome = 0;
  int get tabIndex => _tabIndexHome;

  setTabIndex(newIndexHome) {
    _tabIndexHome = newIndexHome;
    notifyListeners();
  }
}
