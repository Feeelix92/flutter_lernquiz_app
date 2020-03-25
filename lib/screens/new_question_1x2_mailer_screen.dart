import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:hs_fulda/models/category.dart';

class NewQuestionMailer1x2 extends StatefulWidget {
  @override
  _NewQuestionMailer1x2State createState() => _NewQuestionMailer1x2State();
}

class _NewQuestionMailer1x2State extends State<NewQuestionMailer1x2> {
  bool isHTML = false;

  String dropDownStr = "";
  List<String> dropDownAntworten = List<String>(categories.length);

  void buildDropDownItems() {
    for (int i = 0; i < categories.length; i++) {
      Category category = categories[i];
      dropDownAntworten[i] = category.name;
      dropDownStr = dropDownAntworten[0];
    }
    _categoriesController.text = dropDownStr;
  }

  @override
  void initState() {
    buildDropDownItems();
    super.initState();
  }

  final _recipientController = TextEditingController(
    text: 'momo@hbtech.eu',
  );

  final _categoriesController = TextEditingController();

  final _questionController = TextEditingController(
    text: '',
  );

  final _rAController = TextEditingController();
  final _f1AController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> send() async {
    final Email email = Email(
      body: 'Frage: ${_questionController.text}\n'
          '\n'
          'richtige Antwort: \n${_rAController.text}\n'
          'falsche Antwort: \n'
          '${_f1AController.text}',
      subject: '[Neue Frage] ${_categoriesController.text}',
      recipients: [_recipientController.text],
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'Frage erfolgreich abgeschickt';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Frage einreichen'),
        actions: <Widget>[
          IconButton(
            onPressed: send,
            icon: Icon(Icons.send),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
//                  Padding(
//                    padding: EdgeInsets.all(8.0),
//                    child: TextField(
//                      controller: _recipientController,
//                      decoration: InputDecoration(
//                        border: OutlineInputBorder(),
//                        labelText: 'Empfänger',
//                      ),
//                    ),
//                  ),
                Container(
//                  padding: EdgeInsets.all(6.0),
                  child: Text(
                        "Wählen Sie eine Kategorie für Ihre Frage:",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                    textAlign: TextAlign.left,
                      ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: buildDropdownButton(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _questionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Frage',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _rAController,
                    maxLines: 2,
                    decoration: InputDecoration(
                        labelText: 'richtige Antwortmöglichkeit',
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _f1AController,
                    maxLines: 2,
                    decoration: InputDecoration(
                        labelText: 'falsche Antwortmöglichkeit',
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
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
                          "Frage einreichen",
                        ),
                        onPressed: send,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownButton<String> buildDropdownButton() {
    return DropdownButton(
        value: dropDownStr,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontFamily: "Montserrat",
        ),
        onChanged: (newValue) {
          setState(() {
            dropDownStr = newValue;
            _categoriesController.text = dropDownStr;
          });
        },
        items: dropDownAntworten.map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList());
  }
}
