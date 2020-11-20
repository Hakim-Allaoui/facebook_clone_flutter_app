import 'package:facebook_clone_flutter_app/pages/home_page.dart';
import 'package:facebook_clone_flutter_app/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var routes = <String, WidgetBuilder>{
  '/home': (BuildContext context) => HomePage(),
};

void main() {

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    // statusBarBrightness: Brightness.dark,
    statusBarIconBrightness:Brightness.dark,
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Facebook clone',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'San Francisco'
      ),
      routes: routes,
      home: SplashPage(),
    );
  }
}