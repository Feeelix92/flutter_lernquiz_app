import 'package:flutter/material.dart';
import 'package:hs_fulda/models/question_type.dart';
import 'package:hs_fulda/screens/new_question_1x4_mailer_screen.dart';
import 'package:hs_fulda/screens/new_question_1x2_mailer_screen.dart';

class QuestionTypeDialog extends StatefulWidget {
  final QuestionType questiontype;
  final QuestionType questiontypeid;

  const QuestionTypeDialog({Key key, this.questiontype, this.questiontypeid}) : super(key: key);

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

  void changePage(int id) {
    if (id == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              NewQuestionMailer1x4()
          )
      );
      } else
          if (id == 2)
      {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                NewQuestionMailer1x2())
        );
      }
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
            color: Theme
                .of(context)
                .primaryColor,
            child: Text(
              widget.questiontype.text,
              style: Theme
                  .of(context)
                  .textTheme
                  .title
                  .copyWith(),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10.0),
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
                "Frage erstellen",
              ),

              onPressed: () {
                changePage(widget.questiontypeid.id);
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) =>
//                      NewQuestionMailer1x4()), //if id == 1
//                );
              }),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
