import 'dart:io';
import 'dart:typed_data';

import 'package:facebook_clone_flutter_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class Tools{
  static double height = 10.0;
  static double width = 10.0;

  static void getDeviceDimensions(BuildContext context){
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    print('===> height : $height \n===> width  : $width');
  }

  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
      print('==> lunching url : $url');
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<Uint8List> selectPic(BuildContext context) async {
    final picker = ImagePicker();
    Uint8List _image;

    final imageSource = await showModalBottomSheet<ImageSource>(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0))),
        builder: (BuildContext ctx) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 4.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                          color: MyColors.greyLight,
                          borderRadius: BorderRadius.circular(100.0)),
                    ),
                  ),
                ),
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: MyColors.greyLight,
                        borderRadius: BorderRadius.circular(100.0)),
                    child: new Icon(
                      Icons.image,
                      color: MyColors.greyDark,
                    ),
                  ),
                  title: new Text(
                    'Gallery',
                    style: MyTextStyles.titleBold.apply(
                      color: MyColors.greyDark,
                    ),
                  ),
                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                ),
                ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: MyColors.greyLight,
                          borderRadius: BorderRadius.circular(100.0)),
                      child: new Icon(
                        Icons.camera_alt,
                        color: MyColors.greyDark,
                      ),
                    ),
                    title: new Text(
                      'Camera',
                      style: MyTextStyles.titleBold.apply(
                        color: MyColors.greyDark,
                      ),
                    ),
                    onTap: () => Navigator.pop(context, ImageSource.camera)),
              ],
            ),
          );
        });

    if (imageSource != null) {
      final file = await picker.getImage(source: imageSource);
      if (file != null) {
        _image = File(file.path).readAsBytesSync();
      }
    }
    return _image;
  }
}