import 'package:firebase_core/firebase_core.dart';
import 'package:fitverse/components/appinfosetting.dart';
import 'package:fitverse/splashscreen.dart';
import 'package:fitverse/tabandbloc/category_bloc.dart';
import 'package:fitverse/tabandbloc/featured_bloc.dart';
import 'package:fitverse/tabandbloc/recent_contentsbloc.dart';
import 'package:fitverse/tabandbloc/reservationbloc.dart';
import 'package:fitverse/tabandbloc/searchbloc.dart';
import 'package:fitverse/tapandbloc/tabindexhomebloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FeaturedBloc>(
            create: (context) => FeaturedBloc()),
        ChangeNotifierProvider<TabIndexBlocHome>(
            create: (context) => TabIndexBlocHome()),
        ChangeNotifierProvider<RecentBloc>(create: (context) => RecentBloc()),
        ChangeNotifierProvider<SearchAllWellness>(
            create: (context) => SearchAllWellness()),
        ChangeNotifierProvider<CategoryShowBloc>(
            create: (context) => CategoryShowBloc()),
        ChangeNotifierProvider<ReservationShowBloc>(
            create: (context) => ReservationShowBloc()),
        ChangeNotifierProvider<SettingsBloc>(
            create: (context) => SettingsBloc()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.deepOrange),
          home: SplashScreen()),
    );
  }
}
