import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Image.asset('assets/img/bild_home.jpg'),
                buildHeader(
                  "Herzlich Willkommen \nin der Quiz App!",
                ),
                buildText(
                  "Hier können Sie die für Sie prüfungsrelevante Themen erlernen.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildHeader(text) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              //fontStyle: ,
            ),
          ),
        ],
      ),
    );
  }

  Container buildText(text) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Text(
            text,
            //textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
