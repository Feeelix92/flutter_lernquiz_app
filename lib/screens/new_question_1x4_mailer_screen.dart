import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:hs_fulda/models/category.dart';

class NewQuestionMailer1x4 extends StatefulWidget {
  @override
  _NewQuestionMailer1x4State createState() => _NewQuestionMailer1x4State();
}

class _NewQuestionMailer1x4State extends State<NewQuestionMailer1x4> {
  bool isHTML = false;
  bool isValidQuestion = true;
  bool isValidRAnswer = true;
  bool isValidF1Answer = true;
  bool isValidF2Answer = true;
  bool isValidF3Answer = true;

  void checkBeforeSend() {
    if (_questionController.text.isNotEmpty && _rAController.text.isNotEmpty && _f1AController.text.isNotEmpty && _f2AController.text.isNotEmpty && _f3AController.text.isNotEmpty) {
      send();
    } else {
      _onWillPop();
    }
  }

  String dropDownStr = "";
  List<String> dropDownAntworten = List<String>(categories.length);

  void buildDropDownItems() {
    for (int i = 0; i < categories.length; i++) {
      Category category = categories[i];
      dropDownAntworten[i] = category.name;
      dropDownStr = dropDownAntworten[0].toString();
    }
    _categoriesController.text = dropDownStr;
  }

  @override
  void initState() {
    buildDropDownItems();
    super.initState();
  }

  final _recipientController = TextEditingController(
    text: 'momo@hbtech.eu', //e-mail-adresse empfänger
  );

  final _categoriesController = TextEditingController();

  final _questionController = TextEditingController(
    text: '',
  );

  final _rAController = TextEditingController();
  final _f1AController = TextEditingController();
  final _f2AController = TextEditingController();
  final _f3AController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> send() async {
    final Email email = Email(
      body: 'Frage: ${_questionController.text}\n'
          '\n'
          'richtige Antwort: \n${_rAController.text}\n'
          'falsche Antworten: \n'
          '${_f1AController.text} ;\n'
          '${_f2AController.text} ;\n'
          '${_f3AController.text}',
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
//                        labelText: 'Recipient',
//                      ),
//                    ),
//                  ),

                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "Wählen Sie eine Kategorie für Ihre Frage:",
                    style: TextStyle(
                      fontSize: 16,
                    ),
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
                    onChanged: (value) {
                      if (_questionController.text.isNotEmpty) {
                        isValidQuestion = true;
                      } else {
                        isValidQuestion = false;
                      }
                      setState(() {});
                    },
                    maxLines: 3,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Frage',
                        errorText: isValidQuestion ? null : "Frage fehlt"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _rAController,
                    onChanged: (value) {
                      if (_rAController.text.isNotEmpty) {
                        isValidRAnswer = true;
                      } else {
                        isValidRAnswer = false;
                      }
                      setState(() {});
                    },
                    maxLines: 2,
                    decoration: InputDecoration(
                        labelText: 'richtige Antwortmöglichkeit',
                        errorText: isValidRAnswer ? null : "Richtige Antwort fehlt",
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _f1AController,
                    onChanged: (value) {
                      if (_f1AController.text.isNotEmpty) {
                        isValidF1Answer = true;
                      } else {
                        isValidF1Answer = false;
                      }
                      setState(() {});
                    },
                    maxLines: 2,
                    decoration: InputDecoration(
                        labelText: '1. falsche Antwortmöglichkeit',
                        errorText: isValidF1Answer ? null : "Falsche Antwort fehlt",
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _f2AController,
                    onChanged: (value) {
                      if (_f2AController.text.isNotEmpty) {
                        isValidF2Answer = true;
                      } else {
                        isValidF2Answer = false;
                      }
                      setState(() {});
                    },
                    maxLines: 2,
                    decoration: InputDecoration(
                        labelText: '2. falsche Antwortmöglichkeit',
                        errorText: isValidF2Answer ? null : "Falsche Antwort fehlt",
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _f3AController,
                    onChanged: (value) {
                      if (_f3AController.text.isNotEmpty) {
                        isValidF3Answer = true;
                      } else {
                        isValidF3Answer = false;
                      }
                      setState(() {});
                    },
                    maxLines: 2,
                    decoration: InputDecoration(
                        labelText: '3. falsche Antwortmöglichkeit',
                        errorText: isValidF3Answer ? null : "Falsche Antwort fehlt",
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
                        onPressed: checkBeforeSend,
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

  Future<bool> _onWillPop() async {
    return showDialog<bool>(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text(
                "Sie können nur vollständig ausgefüllte Formulare abschicken."),
            title: Text("Achtung!"),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        });
  }
}
