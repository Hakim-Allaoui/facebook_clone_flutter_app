import 'dart:typed_data';

import 'package:facebook_clone_flutter_app/models/reply_model.dart';
import 'package:facebook_clone_flutter_app/models/user_model.dart';

class CommentModel {
  UserModel user;
  String text;
  Uint8List image;
  String elapsedTime;
  int reactionsCount;
  List<ReplyModel> replys;
  List<bool> selectedReacts;

  CommentModel({this.user, this.text = 'Click to add reply text here 📝.', this.image,
    this.elapsedTime = '10m', this.reactionsCount = 0, this.replys, this.selectedReacts});

}
