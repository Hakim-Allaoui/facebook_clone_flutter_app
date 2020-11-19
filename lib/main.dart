import 'package:facebook_clone_flutter_app/pages/home_page.dart';
import 'package:facebook_clone_flutter_app/pages/splash.dart';
import 'package:flutter/material.dart';

var routes = <String, WidgetBuilder>{
  'home': (BuildContext context) => HomePage(),
};

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Facebook clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'San Francisco'
      ),
      routes: routes,
      home: SplashPage(),
    );
  }
}