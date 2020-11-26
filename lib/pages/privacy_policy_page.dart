import 'package:facebook_clone_flutter_app/utils/strings.dart';
import 'package:facebook_clone_flutter_app/utils/theme.dart';
import 'package:facebook_clone_flutter_app/widgets/appbar.dart';
import 'package:facebook_clone_flutter_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPage extends StatefulWidget {
  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: HKDrawer.buildDrawer(context),
      backgroundColor: MyColors.greyLight,
      body: Stack(
        children: <Widget>[
          Positioned(
            right: -100.0,
            bottom: -100.0,
            child: Opacity(
              child: SvgPicture.asset(
                'assets/icons/privacy_policy.svg',
                width: 400.0,
              ),
              opacity: 0.2,
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                color: MyColors.greyLight.withOpacity(0.8),
                child: CustomAppBar(
                  scaffoldKey: scaffoldKey,
                  title: Text(
                    Strings.privacy,
                    style: MyTextStyles.bigTitleBold
                        .apply(color: MyColors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: Markdown(
                  data: Strings.privacyText,
                  onTapLink: (link) async {
                    if (await canLaunch(link)) {
                      await launch(link);
                    } else {
                      throw 'Could not launch $link';
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
