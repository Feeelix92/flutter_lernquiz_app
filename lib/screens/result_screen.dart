import 'package:flutter/material.dart';
import 'package:flutter_lernquiz_app/main.dart';

class ResultPageScreen extends StatefulWidget {

  final punkte;
  final richtigeAntworten;
  final anzahlFragen;
  ResultPageScreen({key, this.punkte, this.richtigeAntworten, this.anzahlFragen}) : super(key: key);

  @override
  _ResultPageScreenState createState() => _ResultPageScreenState(punkte, richtigeAntworten, anzahlFragen);
}

class _ResultPageScreenState extends State<ResultPageScreen> {

  //Platzhalter Bilder für sehr gut, gut und schlecht
  List<String> images = [
    'assets/img/bild_home.jpg', //sehr gut
    'assets/img/bild_home.jpg', //gut
    'assets/img/bild_home.jpg', //schlecht
  ];
  String message;
  String score;
  String image;

  @override
  void initState(){
    score = "Du hast $richtigeAntworten/$anzahlFragen Fragen richtig beantwortet und $punkte Punkte erreicht.";
    if(anzahlFragen/richtigeAntworten <= 2){
      image = images[0];
      message = "$score \n\nSehr gut, an deiner Leistung merkt man, dass du dich mit den Themen beschäftigt hast.";
    }else if(anzahlFragen/richtigeAntworten <= 3){
      image = images[1];
      message = "$score \n\nNicht schlecht, aber nächstes Mal wirst du noch besser abschneiden!";
    }else{
      image = images[2];
      message = "$score \n\nDu solltest dir die Lerninhalte nochmals angucken!";
    }
    super.initState();
  }


  int punkte;
  int richtigeAntworten;
  int anzahlFragen;
  _ResultPageScreenState(this.punkte, this.richtigeAntworten, this.anzahlFragen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ergebnis",
        ),
      ),
      body: ListView(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: Material(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      child: Container(
                        child: ClipRect(
                          child: Image(
                            image: AssetImage(
                              image,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Text(
                           message,
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MyBottomNavigationBar(),
                    ));
                  },
                  child: Text(
                    "Weiter",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  borderSide: BorderSide(
                    width: 3.0,
                    color: Colors.lime,
                  ),
                  splashColor: Colors.lime,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
