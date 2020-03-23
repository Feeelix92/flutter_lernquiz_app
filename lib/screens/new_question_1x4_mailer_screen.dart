import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class NewQuestionMailer1x4 extends StatefulWidget {
  @override
  _NewQuestionMailer1x4State createState() => _NewQuestionMailer1x4State();
}

class _NewQuestionMailer1x4State extends State<NewQuestionMailer1x4> {
  bool isHTML = false;

  final _recipientController = TextEditingController(
    text: 'momo@hbtech.eu',
  );

  final _subjectController = TextEditingController(
    text: '',
  );

  final _bodyController = TextEditingController(
    text: 'Richtige Antwort: '
        '\n\nFalsche Antwort: '
        '\n\nFalsche Antwort: '
        '\n\nFalsche Antwort: ',
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
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
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Frage',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _bodyController,
                    maxLines: 10,
                    decoration: InputDecoration(
                        labelText: 'Antwortmöglichkeiten',
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
                      onPressed: () => Navigator.pop(context),
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
