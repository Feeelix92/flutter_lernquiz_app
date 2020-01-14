import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lernquiz_app/main.dart';
import 'package:flutter_lernquiz_app/screens/thema_waehlen_screen.dart';

class NeueFragenScreen extends StatefulWidget {
  @override
  _NeueFragenScreenState createState() => _NeueFragenScreenState();
}

class _NeueFragenScreenState extends State<NeueFragenScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Neue Fragen"),
        actions: <Widget>[
          Icon(Icons.menu),
        ],
      ),
      body: ListView(
        children: <Widget>[
          titleCard(context, "Wollen Sie eine \nneue Frage erstellen?", Colors.white70, 'assets/img/bild_home.jpg'),
          startButton(context, "Hier starten!", Colors.lime),
        ],
      ),
    );
  }
}

Widget titleCard(context, title, backgroundColor, imagePath) {
  return Padding(
    padding: EdgeInsets.all(
      20.0,
    ),
    child: Material(
        color: backgroundColor,
        elevation: 10.0,
        borderRadius: BorderRadius.circular(
          10.0,
        ),
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(
                    100.0,
                  ),
                  child: Container(
                    height: 200.0,
                    width: 200.0,
                    child: ClipOval(
                      child: Image(
                        image: AssetImage(
                          imagePath,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
              ),
            ],
          ),
        ),
      ),
  );
}
Widget startButton(context, text, backgroundColor) {
  return Padding(
    padding: EdgeInsets.all(
      20.0,
    ),
    child: InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ThemaWaehlenScreen(), //Themenbereich wählen Seite
        ));
      },
      child: Material(
        color: backgroundColor,
        elevation: 10.0,
        borderRadius: BorderRadius.circular(
          10.0,
        ),
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
              ),
              Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildButton(BuildContext context, text, widget) {
  return RaisedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
      );
    },
    child: Text(text),
  );
}
