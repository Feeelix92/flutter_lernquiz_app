import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lernquiz_app/screens/result_screen.dart';

class GetJson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString('assets/test.json'),
      builder: (context, snapshot) {
        List myInput = json.decode(snapshot.data.toString());
        if (myInput == null) {
          return Scaffold(
            body: Center(
              child: Text(
                "Loading",
              ),
            ),
          );
        } else {
          return QuizPage(myInput: myInput);
        }
      },
    );
  }
}

class QuizPage extends StatefulWidget {
  final myInput;

  QuizPage({key, this.myInput}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState(myInput);
}

class _QuizPageState extends State<QuizPage> {
  var myInput;

  _QuizPageState(this.myInput);

  Color colortoshow = Colors.blue;
  Color right = Colors.lime;
  Color wrong = Colors.red;
  int punkte = 0;
  int anzahlFragen = 0;
  int richtigeAntworten = 0;

  //Index um die jeweilige Frage bzw. Antowort aus dem Json zu laden.
  int index = 1;

  //Default Wert für die Zeit je Fragek
  int timer = 30;
  String showTimer = "30";
  bool cancelTimer = false;

  //Ausgangsfarbe der Antwort Buttons
  Map<String, Color> btnColor = {
    "a": Colors.lightBlueAccent,
    "b": Colors.lightBlueAccent,
    "c": Colors.lightBlueAccent,
    "d": Colors.lightBlueAccent,
  };

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  //Funktion wechselt automatisch zur nächsten Frage wenn die Zeit abgelaufen ist.
  void startTimer() async {
    const oneSecond = Duration(seconds: 1);
    Timer.periodic(oneSecond, (time) {
      setState(() {
        if (timer < 1) {
          time.cancel();
          nextQuestion();
        } else if (cancelTimer == true) {
          time.cancel();
        } else {
          timer = timer - 1;
        }
        showTimer = timer.toString();
      });
    });
  }

  //Funktion ändert den Fragenindex bzw. wechselt zur nächsten Frage
  //setzt den Timer und die Button Farben für jede Frage zurück.
  void nextQuestion() {
    cancelTimer = false;
    timer = 30;
    setState(() {
      if (index < 10) {
        index++;
      } else {
        cancelTimer = true;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResultPageScreen(
              punkte: punkte,
              richtigeAntworten: richtigeAntworten,
              anzahlFragen: anzahlFragen),
        ));
      }
      btnColor["a"] = Colors.lightBlueAccent;
      btnColor["b"] = Colors.lightBlueAccent;
      btnColor["c"] = Colors.lightBlueAccent;
      btnColor["d"] = Colors.lightBlueAccent;
    });
    startTimer();
  }

  //Funktion prüft ob die ausgewählte Antwort korrekt ist.
  void checkanswer(option) {
    anzahlFragen++;
    if (myInput[2]["1"] == myInput[1]["1"][option]) {
      punkte = punkte + 5;
      richtigeAntworten++;
      colortoshow = right;
    } else {
      colortoshow = wrong;
    }
    setState(() {
      btnColor[option] = colortoshow;
      cancelTimer = true;
    });
    Timer(Duration(seconds: 2), nextQuestion);
  }

  //Antwort Buttons
  Widget antwortButton(option) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: Container(
        height: 50.0,
        width: 300.0,
        child: MaterialButton(
          onPressed: () => checkanswer(option),
          child: Text(
            myInput[1][index.toString()][option],
            style: TextStyle(
              fontSize: 18.0,
            ),
            maxLines: 1,
          ),
          color: btnColor[option],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome sorgt dafür das die Orientierung immer gleich bleibt auf dem Smartphone Display.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: () {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Hinweis"),
            content: Text("Du kannst an dieser Stelle nicht zurück gehen."),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "OK",
                ),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Multimediagrundlagen"), //Thema Name
          actions: <Widget>[
            Icon(Icons.menu),
          ],
        ),
        body: Column(
          children: <Widget>[
            //Bereich für die Anzeige der Frage
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  myInput[0][index.toString()],
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            //Bereich für die Anzeige der Antwortmöglichkeiten
            Expanded(
              flex: 6,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    antwortButton("a"),
                    antwortButton("b"),
                    antwortButton("c"),
                    antwortButton("d"),
                  ],
                ),
              ),
            ),
            //Bereich für die Anzeige des Timers
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Center(
                  child: Text(
                    showTimer,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
