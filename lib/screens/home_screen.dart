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
          title: Text(
            "Home",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen())),
              icon: Icon(Icons.help),
            ),
          ],
          elevation: 3,
        ),
        body: Stack(children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: new AssetImage('assets/img/tafel_home.jpg'),
                          fit: BoxFit.cover)),
                  child: Center(
                    child: Text(
                      "Herzlich Willkommen \n in der Quiz App!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
//                Image.asset('assets/img/tafel_home.jpg'),
//                Container(
//                  decoration: BoxDecoration(
//                    gradient: LinearGradient(colors: [
//                      Theme.of(context).primaryColor,
//                      Theme.of(context).accentColor
//                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
//                  ),
//                  height: 100,
//                  width: 1000,
//                  child: buildHeader(
//                    "Herzlich Willkommen \nin der Quiz App!",
//                  ),
//                ),
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
