import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lernquiz_app/main.dart';
import 'package:flutter_lernquiz_app/screens/neue_fragen_form_screen.dart';
import 'package:flutter_lernquiz_app/screens/neue_fragen_screen.dart';

class ThemaWaehlenScreen extends StatefulWidget {
  @override
  _ThemaWaehlenScreenState createState() => _ThemaWaehlenScreenState();
}

String dropdownStr = "Multimediagrundlagen"; //neues Thema anlegen auch also Option -- müsste aus Json in Json gespeichert werden
List<String> themen = [
  "Multimediagrundlagen",
  "Programmierung 1",
  "Programmierung 2",
];

class _ThemaWaehlenScreenState extends State<ThemaWaehlenScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Thema wählen"),
        actions: <Widget>[
          Icon(Icons.menu),
        ],
      ),
      body: Column(
        children: <Widget>[
          titleCard(context, "Wählen Sie den Themenbereich Ihrer neuen Frage?",
              Colors.white70, 'assets/img/bild_home.jpg'),
          Container(
            child: buildDropdownButton(),
          ),
          Container(
            child: startButton(context, "weiter", Colors.lime),
          ),
        ],
      ),
    );
  }

  DropdownButton<String> buildDropdownButton() {
    return DropdownButton(
        value: dropdownStr,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
        onChanged: (newValue) {
          setState(() {
            dropdownStr = newValue;
          });
        },
        items: themen.map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList());
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
          builder: (context) =>
//              NeueFragenScreen(), //Fragen erstellen Seite
              NeueFragenFormScreen(), //Fragen erstellen Seite
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
