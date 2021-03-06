import 'package:flutter/material.dart';
import 'package:gharpay/screens/MBSplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GharPay',
      theme: ThemeData(
          fontFamily: "Poppins"
      ),
      home: MBSplashScreen(),
    );
  }
}