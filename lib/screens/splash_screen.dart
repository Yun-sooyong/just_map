import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    super.initState();
    splashTimer();
  }

  splashTimer() {
    Timer(Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, "/test"));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            color: Colors.teal,
            child: Center(
              child: FlutterLogo(),
            ),
          ),
        ),
      ),
    );
  }
}