import 'package:flutter/material.dart';

class Tools{
  static double height = 10.0;
  static double width = 10.0;

  static void getDeviceDimensions(BuildContext context){
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    print('===> height : $height \n===> width = $width');
  }
}