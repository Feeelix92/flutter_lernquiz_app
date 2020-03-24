import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hs_fulda/models/category.dart';
import 'package:hs_fulda/models/question.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:hs_fulda/screens/quiz_finished_screen.dart';
import 'package:html_unescape/html_unescape.dart';

class QuizPage extends StatefulWidget {
  final List<Question> questions;
  final Category category;
  final noOfQuestions;
  final titleColors;

  const QuizPage({Key key, @required this.questions, this.category, this.noOfQuestions, this.titleColors})
      : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final TextStyle _questionStyle = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white);

  int _currentIndex = 0;
  final Map<int, dynamic> _answers = {};
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  //Default Wert für die Zeit je Frage
  Timer _timer;
  int _start = 20;
  String showTimer = "20";
  bool cancelTimer = false;

  // overriding the initstate function to start timer as this screen is created
  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  //Funktion wechselt automatisch zur nächsten Frage wenn die Zeit abgelaufen ist.
  void _startTimer() async {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(
        oneSecond,
        (Timer timer) => setState(() {
              if (_start < 1) {
                timer.cancel();
                _answers[_currentIndex] = "keine Antwort";
                _nextSubmit();
                _startTimer();
              } else if (cancelTimer == true) {
                timer.cancel();
              } else {
                _start = _start - 1;
              }
              showTimer = _start.toString();
            }));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Question question = widget.questions[_currentIndex];
    final List<dynamic> options = question.incorrectAnswers;
    if (!options.contains(question.correctAnswer)) {
      options.add(question.correctAnswer);
      options.shuffle();
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          backgroundColor: widget.titleColors[widget.category.id-1],
          title: Text(
            widget.category.name,
          ),
          elevation: 0,
        ),
        body: Stack(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                decoration:
//                    BoxDecoration(color: Theme.of(context).primaryColor),
                    BoxDecoration(color: widget.titleColors[widget.category.id-1]),
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white70,
                        child: Text("${_currentIndex + 1}"),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Text(
                          HtmlUnescape().convert(
                              widget.questions[_currentIndex].question),
                          softWrap: true,
                          style: _questionStyle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ...options.map((option) => RadioListTile(
                              title: Text(HtmlUnescape().convert("$option")),
                              groupValue: _answers[_currentIndex],
                              value: option,
                              onChanged: (value) {
                                setState(() {
                                  _answers[_currentIndex] = option;
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: CircleAvatar(
                      minRadius: 25.0,
                      maxRadius: 30.0,
                      backgroundColor: Theme.of(context).accentColor,
                      foregroundColor: Colors.white,
                      child: Text(
                        showTimer,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: RaisedButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
//                          _currentIndex == (widget.questions.length - 1)
                          _currentIndex == (widget.noOfQuestions - 1)
                              ? "Quiz beenden"
                              : "weiter",
                        ),
                        onPressed: _nextSubmit,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _nextSubmit() {
    cancelTimer = false;
    _start = 21;
    setState(() {
      if (_answers[_currentIndex] == null && _start > 0) {
        _key.currentState.showSnackBar(SnackBar(
          content: Text("Sie müssen eine Antwort auswählen um fortzufahren."),
        ));
        return;
      }
      if (_currentIndex < ( widget.noOfQuestions - 1)) {
//      if (_currentIndex < (widget.questions.length - 1)) {
        _currentIndex++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => QuizFinishedPage(
                questions: widget.questions, answers: _answers, noOfQuestions: widget.noOfQuestions)));
      }
    });
  }

  Future<bool> _onWillPop() async {
    return showDialog<bool>(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text(
                "Sind Sie sicher, das Sie das Quiz beenden wollen? Ihr Fortschritt geht verloren."),
            title: Text("Achtung!"),
            actions: <Widget>[
              FlatButton(
                child: Text("Ja"),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              FlatButton(
                child: Text("Nein"),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
            ],
          );
        });
  }
}
