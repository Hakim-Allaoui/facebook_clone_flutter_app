import 'dart:typed_data';

import 'package:facebook_clone_flutter_app/models/user_model.dart';
import 'package:facebook_clone_flutter_app/utils/theme.dart';
import 'package:facebook_clone_flutter_app/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePic extends StatefulWidget {
  final UserModel user;
  final bool verified;
  final double size;
  final Function(Uint8List) onClicked;

  const ProfilePic(
      {Key key,
        this.user,
        this.verified = false,
        this.size = 40.0,
        this.onClicked})
      : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size,
      width: widget.size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: MyColors.greyLight,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: GestureDetector(
          onTap: () async {
            widget.user.photo = await Tools.selectPic(context) ??
                widget.user.photo ?? (await rootBundle.load('assets/images/blanks_profile.png'))
                .buffer
                .asUint8List();
            setState(() {});
            if (widget.onClicked != null) widget.onClicked(widget.user.photo);
          },
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              widget.user != null && widget.user.photo != null
                  ? Image.memory(
                widget.user.photo,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                'assets/images/blanks_profile.png',
                fit: BoxFit.cover,
              ),
              widget.verified
                  ? Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black54, Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter)),
                ),
              )
                  : SizedBox(),
              widget.verified
                  ? Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    'assets/icons/profile/guard.svg',
                    width: 15.0,
                    color: Colors.white,
                  ),
                ),
              )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}