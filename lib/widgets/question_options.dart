import 'package:flutter/material.dart';
import 'package:hs_fulda/models/question_type.dart';
import 'package:hs_fulda/screens/new_question_mailer_screen.dart';

class QuestionTypeDialog extends StatefulWidget {
  final QuestionType questiontype;

  const QuestionTypeDialog({Key key, this.questiontype}) : super(key: key);

  @override
  _QuestionTypeDialogState createState() => _QuestionTypeDialogState();
}

class _QuestionTypeDialogState extends State<QuestionTypeDialog> {
  bool processing;

  @override
  void initState() {
    super.initState();
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
            color: Theme.of(context).primaryColor,
            child: Text(
              widget.questiontype.text,
              style: Theme.of(context).textTheme.title.copyWith(),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10.0),
          SizedBox(height: 20.0),
          processing
              ? CircularProgressIndicator()
              : RaisedButton(
                  child: Text(
                    "Frage erstellen",
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewQuestionMailer()),
                    );
                  }),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
