import 'package:facebook_clone_flutter_app/utils/theme.dart';
import 'package:facebook_clone_flutter_app/widgets/rate_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Widget title;
  final Widget leading;
  final Widget bannerAd;
  final VoidCallback showInterCallBack;

  const CustomAppBar(
      {Key key,
      this.scaffoldKey,
      this.bannerAd,
      this.title,
      this.showInterCallBack,
      this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            this.bannerAd != null
                ? Container(height: 50.0, child: this.bannerAd)
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SvgPicture.asset(
                        'assets/icons/burger_menu.svg',
                        color: MyColors.black,
                      ),
                    ),
                    onPressed: () => scaffoldKey.currentState.openDrawer(),
                  ),
                  Expanded(
                    child: this.title,
                  ),
                  leading ??
                      IconButton(
                        icon: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.star,
                            color: MyColors.facebookBlue,
                          ),
                        ),
                        onPressed: () async {
                          int count = 0;
                          await showDialog(
                              context: context,
                              builder: (_) => RatingDialog()).then((value) {
                            count = value ?? 0;
                            if (value == null || value <= 3) {
                              if (showInterCallBack != null)
                                this.showInterCallBack();
                              return;
                            }
                          });
                          String text = '';
                          if (count <= 2)
                            text =
                            'Your rating was $count ☹ alright, thank you.';
                          if (count == 3) text = 'Thanks for your rating 🙂';
                          if (count >= 4) text = 'Thanks for your rating 😀';
                          scaffoldKey.currentState.showSnackBar(
                            new SnackBar(
                              content: Text(text),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
