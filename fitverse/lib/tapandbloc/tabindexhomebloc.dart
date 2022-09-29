import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TabIndexBlocHome extends ChangeNotifier {
  int _tabIndexHome = 0;
  int get tabIndexHome => _tabIndexHome;

  setTabIndexHome(newIndexHome) {
    _tabIndexHome = newIndexHome;
    notifyListeners();
  }
}
