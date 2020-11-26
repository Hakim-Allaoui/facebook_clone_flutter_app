import 'package:flutter/material.dart';

class MyColors{
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color scaffold = Color(0xFFF0F2F5);

  static const Color facebookBlue = Color(0xFF1777F2);


  static Color greyDark = Color(0XFF8A8D92);
  static Color greyLight = Color(0XFFF1F3F4);


  static Color accent = Color(0XFF3D5896);

  static LinearGradient createRoomGradient = LinearGradient(
    colors: [Color(0xFF496AE1), Color(0xFFCE48B1)],
    // colors: [Color(0xFF496AE1), Color(0xFFCE48B1)],
  );

  static const Color online = Color(0xFF4BCB1F);

  static LinearGradient storyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black26],
    // colors: [Colors.transparent, Colors.black26],
  );

}

class MyTextStyles{
  static const TextStyle bigTitleBold = TextStyle(
   fontFamily: 'San Fransiscoo',
    color: MyColors.black,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle titleBold = TextStyle(
   fontFamily: 'San Fransiscoo',
    color: MyColors.black,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle subTitleBold = TextStyle(
   fontFamily: 'San Fransiscoo',
    color: MyColors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );

  //Normal
  static const TextStyle bigTitle = TextStyle(
   fontFamily: 'San Fransiscoo',
    color: MyColors.black,
    fontSize: 20.0,
  );
  static const TextStyle title = TextStyle(
   fontFamily: 'San Fransiscoo',
    color: MyColors.black,
    fontSize: 18.0,
  );
  static const TextStyle subTitle = TextStyle(
   fontFamily: 'San Fransiscoo',
    color: MyColors.black,
    fontSize: 16.0,
  );

  //Thin
  static const TextStyle bigTitleThin = TextStyle(
   fontFamily: 'San Fransiscoo',
    color: MyColors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.w100,
  );
  static const TextStyle titleThin = TextStyle(
   fontFamily: 'San Fransiscoo',
    color: MyColors.black,
    fontSize: 18.0,
    fontWeight: FontWeight.w100,
  );
  static const TextStyle subTitleThin = TextStyle(
   fontFamily: 'San Fransiscoo',
    color: MyColors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w100,
  );

  static const TextStyle fbTitleBigBold = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );
  static const TextStyle fbTitleBold = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  static const TextStyle fbTitle = TextStyle(
    fontSize: 16.0,
  );
  static const TextStyle fbSubTitleBold = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
  );
  static const TextStyle fbText = TextStyle(
    fontSize: 14.0,
  );
}