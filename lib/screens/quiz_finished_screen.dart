import 'package:flutter/material.dart';
import 'package:hs_fulda/models/question.dart';
import 'package:hs_fulda/screens/check_answers_screen.dart';

// ignore: must_be_immutable
class QuizFinishedPage extends StatelessWidget {
  final List<Question> questions;
  final Map<int, dynamic> answers;
  final noOfQuestions;

  int correctAnswers;

  QuizFinishedPage(
      {Key key,
      @required this.questions,
      @required this.answers,
      this.noOfQuestions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int correct = 0;
    this.answers.forEach((index, value) {
      if (this.questions[index].correctAnswer == value) correct++;
    });
    final TextStyle titleStyle = TextStyle(
        color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.w500);
    final TextStyle trailingStyle = TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ergebnis',
        ),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).accentColor
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Gesamtanzahl Fragen", style: titleStyle),
//                  trailing: Text("${questions.length}", style: trailingStyle),
                  trailing: Text("${noOfQuestions}", style: trailingStyle),
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Score", style: titleStyle),
                  trailing: Text("${correct / noOfQuestions * 100}%",
                      style: trailingStyle),
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Korrekte Antworten", style: titleStyle),
                  trailing:
                      Text("$correct/${noOfQuestions}", style: trailingStyle),
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Falsche Antworten", style: titleStyle),
                  trailing: Text("${noOfQuestions - correct}/${noOfQuestions}",
                      style: trailingStyle),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Theme.of(context).buttonColor,
                        child: Text("Zurück"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      RaisedButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Theme.of(context).buttonColor,
                        child: Text(
                          "Antworten prüfen",
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => CheckAnswersPage(
                                  questions: questions,
                                  answers: answers,
                                  noOfQuestions: noOfQuestions)));
                        },
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
