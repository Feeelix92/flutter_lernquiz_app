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
        actions: <Widget>[
          Icon(Icons.menu),
        ],
      ),
      body: ListView(
        children: <Widget>[
          themenCard(context, "Multimediagrundlagen", Colors.lime,
              'assets/img/bild_home.jpg'),
          themenCard(
            context,
            "Programmierung 1",
            Colors.indigo,
            'assets/img/bild_home.jpg',
          ),
          themenCard(
            context,
            "Programmierung 2",
            Colors.orange,
            'assets/img/bild_home.jpg',
          ),
        ],
      ),

//      body: Center(
//        child: Column(
//          children: <Widget>[
//            buildButton(context, "Multimediagrundlagen", HomeScreen()),
//            buildButton(context, "Programmierung 1", HomeScreen()),
//            buildButton(context, "Programmierung 2", HomeScreen()),
//          ],
//        ),
//      ),
    );
  }
}

Widget themenCard(context, title, backgroundColor, imagePath) {
  return Padding(
    padding: EdgeInsets.all(
      20.0,
    ),
    child: InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => GetJson(),
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
