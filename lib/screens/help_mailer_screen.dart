import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class HelpMailer extends StatefulWidget {
  @override
  _HelpMailerState createState() => _HelpMailerState();
}

class _HelpMailerState extends State<HelpMailer> {
  bool isHTML = false;
  bool isValidQuestion = true;
  bool isValidRAnswer = true;
  bool isValidF1Answer = true;

  void checkBeforeSend() {
    if (_subjectController.text.isNotEmpty && _messageController.text.isNotEmpty) {
      send();
    } else {
      _onWillPop();
    }
  }

  final _recipientController = TextEditingController(
    text: 'momo@hbtech.eu', //e-mail-adresse empfänger
  );

  final _subjectController = TextEditingController(
    text: '',
  );

  final _messageController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> send() async {
    final Email email = Email(
      body: '${_messageController.text}\n',
      subject: '[Problem] ${_subjectController.text}',
      recipients: [_recipientController.text],
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'Problem erfolgreich abgeschickt';
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
        title: Text('Hilfe'),
        actions: <Widget>[
          IconButton(
            onPressed: checkBeforeSend,
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
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "Beschreiben Sie Ihr Problem:",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _subjectController,
                    onChanged: (value) {
                      if (_subjectController.text.isNotEmpty) {
                        isValidQuestion = true;
                      } else {
                        isValidQuestion = false;
                      }
                      setState(() {});
                    },
                    maxLines: 2,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Betreff',
                        errorText: isValidQuestion ? null : "Betreff fehlt"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _messageController,
                    onChanged: (value) {
                      if (_messageController.text.isNotEmpty) {
                        isValidRAnswer = true;
                      } else {
                        isValidRAnswer = false;
                      }
                      setState(() {});
                    },
                    maxLines: 10,
                    decoration: InputDecoration(
                        labelText: 'Ihre Nachricht',
                        errorText: isValidRAnswer ? null : "Nachricht fehlt",
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
                          "Abschicken",
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
