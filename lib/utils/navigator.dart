import 'package:flutter/material.dart';

class HKNavigator{
  static void goHome(BuildContext context){
    Navigator.pushReplacementNamed(context, '/home');
  }

  static void goPost(BuildContext context){
    Navigator.pushNamed(context, '/post');
  }

  static void goPrivacy(BuildContext context){
    Navigator.pushNamed(context, '/privacy');
  }

  static void goAbout(BuildContext context){
    Navigator.pushNamed(context, '/about');
  }
}