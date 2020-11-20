import 'package:facebook_clone_flutter_app/utils/navigator.dart';
import 'package:facebook_clone_flutter_app/utils/tools.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      HKNavigator.goHome(context);
    });

  }

  @override
  Widget build(BuildContext context) {
    Tools.getDeviceDimensions(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset('assets/icon.png', width: Tools.width * 0.3,),
        ),
      ),
    );
  }
}
