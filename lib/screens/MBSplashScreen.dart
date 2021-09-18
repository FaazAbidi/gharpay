import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gharpay/screens/MBWalkThroughScreen.dart';
import 'package:gharpay/utils/MBImages.dart';
import 'package:nb_utils/nb_utils.dart';

class MBSplashScreen extends StatefulWidget {
  @override
  MBSplashScreenState createState() => MBSplashScreenState();
}

class MBSplashScreenState extends State<MBSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      finish(context);
      return MBWalkThroughScreen().launch(context);
    });
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Image.asset("images/logo.png", height: 200, width: 200).cornerRadiusWithClipRRect(16), 16.height,
          // Text('Paisa lay', textAlign: TextAlign.center, style: boldTextStyle())
        ],
      ).center(),
    );
  }
}
