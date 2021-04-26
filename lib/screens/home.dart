import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: RaisedButton(
            child: Text('MAP'),
            onPressed: () => Navigator.pushReplacementNamed(context, "/map"),
          ),
        ),
      ),
    );
  }
}
