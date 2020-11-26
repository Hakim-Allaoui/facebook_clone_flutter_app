import 'package:facebook_clone_flutter_app/utils/strings.dart';
import 'package:facebook_clone_flutter_app/utils/theme.dart';
import 'package:facebook_clone_flutter_app/widgets/appbar.dart';
import 'package:facebook_clone_flutter_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:facebook_clone_flutter_app/utils/navigator.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to Exit?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: new Text('Cancel'),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: new Text('Exit'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: scaffoldKey,
        drawer: HKDrawer.buildDrawer(context),
        body: Column(
          children: [
            CustomAppBar(
              scaffoldKey: scaffoldKey,
              title: Text(
                'Fake It: FB Post',
                style: MyTextStyles.titleBold.apply(fontFamily: ''),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Markdown(
                data: Strings.disclaimer,
                onTapLink: (link) async {
                  if (await canLaunch(link)) {
                    await launch(link);
                  } else {
                    throw 'Could not launch $link';
                  }
                },
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Color(0xffFFFFAA),
                        border: Border.all(
                          color: Color(0xffFFAD33),
                          width: 1.0,
                        )),
                    child: Markdown(
                      data: """

  

- 🤗 Click Button below 👇 to start Editing.
- 👆 Select any thing you want to modify.
- 📃 Add comments and replies.
- 😃 Customize post, comment, reply reactions number and Arrangement.
- 📸 Take Screenshot.
                      """,
                      onTapLink: (link) async {
                        if (await canLaunch(link)) {
                          await launch(link);
                        } else {
                          throw 'Could not launch $link';
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xffFFFFAA),
                          border: Border.all(
                            color: Color(0xffFFAD33),
                            width: 1.0,
                          )),
                      child: Text('💡 How to use'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(100.0),
                        gradient: RadialGradient(
                          colors: [
                            Color(0xff0884FF),
                            Color(0xff9D35FF),
                            Color(0xffFF6868),
                          ],
                          center: Alignment.bottomLeft,
                          radius: 2.0,
                        )),
                    child: FlatButton(
                        padding: EdgeInsets.all(20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(100.0),
                        ),
                        child: new Text(
                          'Create Post',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          HKNavigator.goPost(context);
                        }),
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
