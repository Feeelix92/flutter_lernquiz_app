import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lernquiz_app/main.dart';
import 'package:flutter_lernquiz_app/model/antworten.dart';
import 'package:flutter_lernquiz_app/model/themen.dart';
import 'package:flutter_lernquiz_app/screens/thema_waehlen_screen.dart';

class NeueFragenScreen extends StatefulWidget {

//  final themenId;
//  final themenName;

//  NeueFragenScreen({key, this.themenId, this.themenName}) : super(key: key);

  @override
  _NeueFragenScreenState createState() => _NeueFragenScreenState();
}

String dropdownStr = "A";
List<String> dropDownAntworten = [
  "A",
  "B",
  "C",
  "D",
];
String richtigeAntwort;

class _NeueFragenScreenState extends State<NeueFragenScreen> {
  //@override

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
          buildAnswerField("Antwortmöglichkeit A", aController),
          Text(aController.text),
          buildAnswerField("Antwortmöglichkeit B", bController),
          Text(bController.text),
          buildAnswerField("Antwortmöglichkeit C", cController),
          Text(cController.text),
          buildAnswerField("Antwortmöglichkeit D", dController),
          Text(dController.text),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Text("Wählen Sie hier die zutreffende Antwort aus:",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black45,
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: buildDropdownButton(),
            ),
          ),
//          startButton(context, "Speichern & Weiter", Colors.lime),
//          //funktion zum speichern der daten in json
//          buildButton(context, "start", aController, bController, cController, dController, questionController)
        ],
      ),
    );
  }

  String question;

  final questionController = TextEditingController();
  final aController = TextEditingController();
  final bController = TextEditingController();
  final cController = TextEditingController();
  final dController = TextEditingController();
  final rController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    questionController.dispose();
    aController.dispose();
    bController.dispose();
    cController.dispose();
    dController.dispose();
    super.dispose();
  }

//  void saveAnswer() {
//    setState(() {
////      Map<String, dynamic> answers = {
////        "a": aController.text.toString(),
////        "b": bController.text.toString(),
////        "c": cController.text.toString(),
////        "d": dController.text.toString(),
////      };
//
//        if(dropdownStr == "A"){
//          richtigeAntwort = aController.text.toString();
//        }else if(dropdownStr == "B"){
//          richtigeAntwort = bController.text.toString();
//        }else if(dropdownStr == "C"){
//          richtigeAntwort = cController.text.toString();
//        }else{
//          richtigeAntwort = dController.text.toString();
//        }
//
////      Map<String, dynamic> theme = {
////        "themenId": "",
////        "themenName": "",
////        "fragenId": "",
////        "fragenName": questionController,
////        "antworten": answers,
////        "antwortR": richtigeAntwort,
////      };
//
//      Antworten antworten = Antworten(aController.text.toString(), bController.text.toString(), cController.text.toString(), dController.text.toString());
//      Themen themen = Themen(1, "", 1, questionController.text.toString(), antworten, richtigeAntwort);
//      print(themen.toJson());
//
//    });
//  }

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
        items: dropDownAntworten.map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList());
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
      onTap: () {
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

//Widget buildButton(BuildContext context, text, aController, bController, cController, dController, questionController) {
//  return RaisedButton(
//    onPressed: () => saveAnswer(aController, bController, cController, dController, questionController),
////    onPressed: () {
////      Navigator.push(
////        context,
////        MaterialPageRoute(
////          builder: (context) => widget,
////        ),
////      );
////    },
//    child: Text(text),
//  );
//}
//
//void saveAnswer(aController, bController, cController, dController, questionController) {
//  if(dropdownStr == "A"){
//          richtigeAntwort = aController.text.toString();
//        }else if(dropdownStr == "B"){
//          richtigeAntwort = bController.text.toString();
//        }else if(dropdownStr == "C"){
//          richtigeAntwort = cController.text.toString();
//        }else{
//          richtigeAntwort = dController.text.toString();
//        }
//
//  Antworten antworten = Antworten(aController.text.toString(), bController.text.toString(), cController.text.toString(), dController.text.toString());
//  Themen themen = Themen(1, "", 1, questionController.text.toString(), antworten, richtigeAntwort);
//  print(themen.toJson());
//  String json = jsonEncode(themen);
//  print(json);
//}
