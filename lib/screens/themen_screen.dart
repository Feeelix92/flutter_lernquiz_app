import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lernquiz_app/screens/quiz_screen.dart';

class ThemenScreen extends StatefulWidget {
  @override
  _ThemenScreenState createState() => _ThemenScreenState();
}

class _ThemenScreenState extends State<ThemenScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Themen"),
      ),
      body: ListView(
        children: <Widget>[
          themenCard(
            context,
            "test",
            "Multimediagrundlagen",
            Colors.lime,
            images[0],
          ),
          themenCard(
            context,
            "test",
            "Programmierung 1",
            Colors.lightBlueAccent,
            images[0],
          ),
          themenCard(
            context,
            "test",
            "Programmierung 2",
            Colors.orange,
            images[0],
          ),
        ],
      ),
    );
  }
}

List<String> images = [
  'assets/img/bild_home.jpg',
  'assets/img/bild_home.jpg',
  'assets/img/bild_home.jpg',
  'assets/img/bild_home.jpg',
  'assets/img/bild_home.jpg',
];

Widget themenCard(context, langname, title, backgroundColor, imagePath) {
  return Padding(
    padding: EdgeInsets.all(
      20.0,
    ),
    child: InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => GetJson(langname),
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
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
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
