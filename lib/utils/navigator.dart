import 'package:flutter/material.dart';

class HKNavigator{
  static void goHome(BuildContext context){
    Navigator.pushReplacementNamed(context, '/home');
  }
}