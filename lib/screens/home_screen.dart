import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Home",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          elevation: 2,
        ),
        body: Stack(children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).accentColor
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              height: 200,
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
//                Image.asset('assets/img/bild_home.jpg'),
                buildHeader(
                  "Herzlich Willkommen \nin der Quiz App!",
                ),
                Image.asset('assets/img/bild_home.jpg'),
                buildText(
                  "Hier können Sie prüfungsrelevante Inhalte schnell und einfach lernen. Und weil uns noch kein besserer Text eingefallen ist steht das hier so.",
                ),
              ],
            ),
          ),
        ]));
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
              color: Colors.white,
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
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
