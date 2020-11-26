import 'package:facebook_clone_flutter_app/pages/about_page.dart';
import 'package:facebook_clone_flutter_app/pages/home_page.dart';
import 'package:facebook_clone_flutter_app/pages/post_page.dart';
import 'package:facebook_clone_flutter_app/pages/privacy_policy_page.dart';
import 'package:facebook_clone_flutter_app/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var routes = <String, WidgetBuilder>{
  '/home': (BuildContext context) => HomePage(),
  '/post': (BuildContext context) => PostPage(),
  '/about': (BuildContext context) => AboutPage(),
  '/privacy': (BuildContext context) => PrivacyPage(),
};

void main() {

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
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
        fontFamily: 'San Franciscoo'
      ),
      routes: routes,
      home: SplashPage(),
    );
  }
}