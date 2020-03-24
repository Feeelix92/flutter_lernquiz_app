import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hs_fulda/models/category.dart';
import 'package:hs_fulda/models/question.dart';
import 'package:hs_fulda/resources/api_provider.dart';
import 'package:hs_fulda/screens/error_screen.dart';
import 'package:hs_fulda/screens/quiz_page_screen.dart';

class QuizOptionsDialog extends StatefulWidget {
  final Category category;
  final titleColors;

  const QuizOptionsDialog({Key key, this.category, this.titleColors}) : super(key: key);

  @override
  _QuizOptionsDialogState createState() => _QuizOptionsDialogState();
}

class _QuizOptionsDialogState extends State<QuizOptionsDialog> {
  int _noOfQuestions;
  bool processing;

  @override
  void initState() {
    super.initState();
    _noOfQuestions = 5;
    processing = false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment(0, 0),
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: widget.titleColors[widget.category.id-1],
//            color: Theme.of(context).primaryColor,
            child: Text(
              widget.category.name,
              style: Theme.of(context).textTheme.title.copyWith(),
            ),
          ),
          SizedBox(height: 10.0),
          Text("Wie viele Fragen wollen sie zum Thema beantworten?"),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              runSpacing: 16.0,
              spacing: 16.0,
              children: <Widget>[
                SizedBox(width: 0.0),
                ActionChip(
                  label: Text("5"),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: _noOfQuestions == 5 ? Colors.pink : Colors.grey.shade500,
                  onPressed: () => _selectNumberOfQuestions(5),
                ),
                ActionChip(
                  label: Text("10"),
                  labelStyle: TextStyle(color: Colors.white),
                  backgroundColor: _noOfQuestions == 10 ? Colors.pink : Colors.grey.shade500,
                  onPressed: () => _selectNumberOfQuestions(10),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          processing
              ? CircularProgressIndicator()
              : RaisedButton(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    "Quiz starten",
                  ),
                  onPressed: _startQuiz,
                ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  _selectNumberOfQuestions(int i) {
    setState(() {
      _noOfQuestions = i;
    });
  }

  void _startQuiz() async {
    setState(() {
      processing = true;
    });
    try {
      List<Question> questions = await getQuestions(context, widget.category);
      Navigator.pop(context);
      if (questions.length < 1) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ErrorPage(
                  message:
                      "Es gibt im ausgewählten Themenbereich nicht genügend Fragen.",
                )));
        return;
      }
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => QuizPage(
                    questions: questions,
                    category: widget.category,
                    noOfQuestions: _noOfQuestions,
                    titleColors: widget.titleColors,
                  )));
    } on SocketException catch (_) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => ErrorPage(
                    message:
                        "Server nicht erreichbar, \n Bitte überprüfen Sie Ihre Internetverbindung.",
                  )));
    } catch (e) {
      print(e.message);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => ErrorPage(
                    message: "Unbekannter Fehler beim Versuch mit der API zu verbinden.",
                  )));
    }
    setState(() {
      processing = false;
    });
  }
}
