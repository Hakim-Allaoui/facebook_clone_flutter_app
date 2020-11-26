import 'dart:typed_data';

import 'package:facebook_clone_flutter_app/models/user_model.dart';
class ReplyModel {
  UserModel user;

  String text;
  Uint8List image;
  String elapsedTime;
  int reactionsCount;
  List<bool> selectedReacts;

  ReplyModel(
      {this.user,
      this.text = 'Click to add reply text here ✍.',
      this.image,
      this.elapsedTime = '10m',
      this.reactionsCount = 0,
      this.selectedReacts});
}
