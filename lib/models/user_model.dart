import 'dart:typed_data';
class UserModel {
  String name;
  String otherName;
  Uint8List photo;
  Uint8List cover;
  String bio;
  bool verified;

  UserModel({this.name = 'User Name', this.otherName = 'Other name', this.photo, this.cover,
    this.bio = 'Here is the bio', this.verified = false});
}
