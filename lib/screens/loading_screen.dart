import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_lernquiz_app/main.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MyBottomNavigationBar(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime,
      body: Center(
        child: Text(
          "Quiz App",
          style: TextStyle(
            fontSize: 50.0,
            color: Colors.white,
          ),
        )
      ),
    );
  }
}
