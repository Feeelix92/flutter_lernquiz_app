import 'package:flutter/cupertino.dart';
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

  String question;
  String a;
  String b;
  String c;
  String d;

  final questionController = TextEditingController();
  final aController = TextEditingController();
  final bController = TextEditingController();
  final cController = TextEditingController();
  final dController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    aController.dispose();
    bController.dispose();
    cController.dispose();
    dController.dispose();
    questionController.dispose();
    super.dispose();
  }

  void saveAnswer(){
    setState(() {
      question = questionController.toString();
      a = aController.toString();
      b = bController.toString();
      c = cController.toString();
      d = dController.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Neue Frage erstellen"),
        actions: <Widget>[
          Icon(Icons.menu),
        ],
      ),
      body: ListView(
        children: <Widget>[
          //Hier muss Frage eingegeben werden

         // titleCard(context, "Wie lautet Ihre\nneue Frage?", Colors.white70,
          //    'assets/img/bild_home.jpg'),
          //Textfeld für Frage
          buildQuestionField("Hier Ihre Frage eingeben", questionController),
          Text(questionController.text),
          buildAnswerField("Richtige Antwortmöglichkeit A", aController),
          Text(aController.text),
          buildAnswerField("Falsche Antwortmöglichkeit B", bController),
          Text(bController.text),
          buildAnswerField("Falsche Antwortmöglichkeit C", cController),
          Text(cController.text),
          buildAnswerField("Falsche Antwortmöglichkeit D", dController),
          Text(dController.text),
          startButton(context, "Speichern & Weiter", Colors.lime), //funktion zum speichern der daten in json
        ],
      ),
    );
  }

  Container buildAnswerField(text, controller) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 20.0,
      ),
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          fontSize: 15,
        ),
        decoration: InputDecoration(labelText: text),
      ),
    );
  }

  Container buildQuestionField(text, controller) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(labelText: text),
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
      onTap: (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              MyBottomNavigationBar(), //Themenbereich wählen Seite
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
