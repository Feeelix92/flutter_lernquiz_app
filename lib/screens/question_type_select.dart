import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:hs_fulda/models/question_type.dart';
import 'package:hs_fulda/widgets/question_options.dart';
import 'package:auto_size_text/auto_size_text.dart';

class QuestionTypeSelect extends StatelessWidget {
  final List<Color> tileColors = [
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.indigo,
    Colors.lightBlue,
    Colors.amber,
    Colors.deepOrange,
    Colors.red,
    Colors.brown
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Fragentyp wählen',
          ),
          elevation: 0,
        ),
        body: Stack(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
                height: 200,
              ),
            ),
            CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      "Wählen Sie eine Art der Frage um eine neue Frage einreichen zu können.",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 2.0,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0),
                      delegate: SliverChildBuilderDelegate(
                        _buildQuestionType,
                        childCount: questiontypes.length,
                      )),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _buildQuestionType(BuildContext context, int index) {
    QuestionType questiontype = questiontypes[index];
    QuestionType id = questiontypes[index];
    return MaterialButton(
      elevation: 1.0,
      highlightElevation: 1.0,
      onPressed: () => _questionPressed(context, questiontype, id),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Theme.of(context).buttonColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AutoSizeText(
            questiontype.text,
            minFontSize: 18.0,
            textAlign: TextAlign.center,
            maxLines: 4,
            wrapWords: false,
          ),
        ],

      ),
    );
  }

  _questionPressed(BuildContext context, QuestionType questiontype, QuestionType id) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => BottomSheet(
        builder: (_) => QuestionTypeDialog(
          questiontype: questiontype,
          questiontypeid: id,
        ),
        onClosing: () {},
      ),
    );
  }
}
