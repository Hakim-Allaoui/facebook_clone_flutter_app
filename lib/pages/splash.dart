import 'package:facebook_clone_flutter_app/utils/navigator.dart';
import 'package:facebook_clone_flutter_app/utils/theme.dart';
import 'package:facebook_clone_flutter_app/utils/tools.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  initThenGoHomeScreen() {
    Future.wait([
      Future.delayed(
          Duration(seconds: 5),
              () => print(
              "===( Future )============= delayed ======================> : Just delayed"))
    ]).then((value) {
      HKNavigator.goHome(context);
      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return TestPage();
      // }));
    });
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    controller.repeat(reverse: true);
    initThenGoHomeScreen();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Tools.getDeviceDimensions(context);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: MyColors.scaffold,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: Center(
                  child: ScaleTransition(
                    scale: Tween(begin: 1.0, end: 1.1).animate(CurvedAnimation(
                        parent: controller, curve: Curves.ease)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        'assets/icon.png',
                        width: Tools.width / 4,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text('Initializing...', style: MyTextStyles.bigTitle),
            ),
          ],
        ),
      ),
    );
  }
}
