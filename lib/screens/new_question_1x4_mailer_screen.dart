import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import '../main.dart';

class NewQuestionMailer1x4 extends StatefulWidget {
  @override
  _NewQuestionMailer1x4State createState() => _NewQuestionMailer1x4State();
}

class _NewQuestionMailer1x4State extends State<NewQuestionMailer1x4> {
  bool isHTML = false;

  final _recipientController = TextEditingController(
    text: 'momo@hbtech.eu', //e-mail-adresse empfänger
  );

  final _subjectController = TextEditingController(
    text: '',
  );

  final _rAController = TextEditingController();
  final _f1AController = TextEditingController();
  final _f2AController = TextEditingController();
  final _f3AController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> send() async {

    final Email email = Email(
      body: 'richtige Antwort: \n' +
          _rAController.text +
          '\nfalsche Antworten: \n1. ' +
          _f1AController.text +
          '\n2. ' +
          _f2AController.text +
          '\n3. ' +
          _f3AController.text ,
      subject: '[Neue Frage eingereicht] ' + _subjectController.text,
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
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _subjectController,
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
                        labelText: '1. falsche Antwortmöglichkeit',
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _f2AController,
                    maxLines: 2,
                    decoration: InputDecoration(
                        labelText: '2. falsche Antwortmöglichkeit',
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _f3AController,
                    maxLines: 2,
                    decoration: InputDecoration(
                        labelText: '3. falsche Antwortmöglichkeit',
                        border: OutlineInputBorder()),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Theme.of(context).buttonColor,
                      child: Text("Zurück"),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => MyBottomNavigationBar(),
                        ));
                      },
                    ),
                    RaisedButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20.0),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
