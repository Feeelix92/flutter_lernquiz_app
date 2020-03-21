import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hs_fulda/models/category.dart';
import 'package:hs_fulda/models/question.dart';
import 'package:hs_fulda/resources/api_provider.dart';
import 'package:hs_fulda/screens/error_screen.dart';
import 'package:hs_fulda/screens/quiz_page_screen.dart';

class QuizOptionsDialog extends StatefulWidget {
  final Category category;

  const QuizOptionsDialog({Key key, this.category}) : super(key: key);

  @override
  _QuizOptionsDialogState createState() => _QuizOptionsDialogState();
}

class _QuizOptionsDialogState extends State<QuizOptionsDialog> {
  int _noOfQuestions;
  bool processing;

  @override
  void initState() {
    super.initState();
    _noOfQuestions = 10;
    processing = false;
  }

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey.shade200,
            child: Text(widget.category.name, style: Theme.of(context).textTheme.title.copyWith(),),
          ),
          SizedBox(height: 10.0),
//          Text("Wie viele Fragen wollen sie zum Thema beantworten?"),
//          SizedBox(
//            width: double.infinity,
//            child: Wrap(
//              alignment: WrapAlignment.center,
//              runAlignment: WrapAlignment.center,
//              runSpacing: 16.0,
//              spacing: 16.0,
//              children: <Widget>[
//                SizedBox(width: 0.0),
////                ActionChip(
////                  label: Text("10"),
////                  labelStyle: TextStyle(color: Colors.white),
////                  backgroundColor: _noOfQuestions == 10 ? Colors.pink : Colors.grey.shade500,
////                  onPressed: () => _selectNumberOfQuestions(10),
////                ),
////                ActionChip(
////                  label: Text("20"),
////                  labelStyle: TextStyle(color: Colors.white),
////                  backgroundColor: _noOfQuestions == 20 ? Colors.pink : Colors.grey.shade500,
////                  onPressed: () => _selectNumberOfQuestions(20),
////                ),
//              ],
//            ),
//          ),
          SizedBox(height: 20.0),
          processing ? CircularProgressIndicator() : RaisedButton(
            child: Text("Start Quiz"),
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
      processing=true;
    });
    try {
      List<Question> questions =  await getQuestions(context, widget.category);
      Navigator.pop(context);
      if(questions.length < 1) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ErrorPage(message: "There are not enough questions in the category, with the options you selected.",)
        ));
        return;
      }
      Navigator.push(context, MaterialPageRoute(
          builder: (_) => QuizPage(questions: questions, category: widget.category,)
      ));
    }on SocketException catch (_) {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (_) => ErrorPage(message: "Can't reach the servers, \n Please check your internet connection.",)
      ));
    } catch(e){
      print(e.message);
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (_) => ErrorPage(message: "Unexpected error trying to connect to the API",)
      ));
    }
    setState(() {
      processing=false;
    });
  }
}