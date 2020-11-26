import 'dart:typed_data';

import 'package:facebook_clone_flutter_app/models/comment_model.dart';
import 'package:facebook_clone_flutter_app/models/user_model.dart';

class PostModel{
  UserModel user;
  String body;
  List<Uint8List> images;
  String elapsedTime ;
  int reactionsCount;
  int commentsCount;
  int shareCount;
  List<CommentModel> comments;

  PostModel({this.user, this.body = 'Click to write your own post text',this.images ,this.elapsedTime = '10m', this.reactionsCount = 1, this.shareCount = 1, this.commentsCount = 1,
    this.comments});
}
