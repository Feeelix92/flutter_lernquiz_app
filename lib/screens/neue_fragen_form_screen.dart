//https://codingwithjoe.com/building-forms-with-flutter/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lernquiz_app/main.dart';
import 'package:flutter_lernquiz_app/model/fragenService.dart';
import 'package:flutter_lernquiz_app/model/neueFragen.dart';

Fragen newFragen = new Fragen();

class NeueFragenFormScreen extends StatefulWidget {
  @override
  _NeueFragenFormScreenState createState() => _NeueFragenFormScreenState();
}

class _NeueFragenFormScreenState extends State<NeueFragenFormScreen> {
  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      showMessage('Form ist nicht gültig! Bitte überarbeiten.');
    } else {
      form.save(); //This invokes each onSaved event

      print('Form Speicherung abgerufen, newFragen ist nun aktuell...');
      print('Thema: ${newFragen.thema}');
      print('Frage: ${newFragen.frage}');
      print('Antwort A: ${newFragen.antwortA}');
      print('Antwort B: ${newFragen.antwortB}');
      print('Antwort C: ${newFragen.antwortC}');
      print('Antwort D: ${newFragen.antwortD}');
      print('Zutreffende Antwort: ${newFragen.richtigeAntwort}');
      print('========================================');
      print('Ins Backend einreichen...');
      var fragenService = new FragenService();
      fragenService.createContact(newFragen).then((value) => showMessage(
          'Neue Frage erstellt für: "${value.frage}"!', Colors.lightGreen));
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<String> _rAntworten = <String>['', 'A', 'B', 'C', 'D'];
  String _rAntwort = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Neue Frage einreichen"),
        actions: <Widget>[
          Icon(Icons.menu),
        ],
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          key: _formKey,
          autovalidate: false,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Geben Sie hier das Thema der Frage ein',
                  labelText: 'Thema',
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
                validator: (val) => val.isEmpty ? 'Thema wird benötigt' : null,
                onSaved: (val) => newFragen.thema = val,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Geben Sie hier Ihre neue Frage ein',
                  labelText: 'Frage',
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
                validator: (val) => val.isEmpty ? 'Frage wird benötigt' : null,
                onSaved: (val) => newFragen.frage = val,
              ),
               TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Geben Sie hier Ihre erste Antwortmöglichkeit ein',
                  labelText: 'Antwort A',
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
                validator: (val) =>
                    val.isEmpty ? 'Antwort wird benötigt' : null,
                onSaved: (val) => newFragen.antwortA = val,
              ),
               TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Geben Sie hier Ihre zweite Antwortmöglichkeit ein',
                  labelText: 'Antwort B',
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
                validator: (val) =>
                    val.isEmpty ? 'Antwort wird benötigt' : null,
                onSaved: (val) => newFragen.antwortB = val,
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Geben Sie hier Ihre dritte Antwortmöglichkeit ein',
                  labelText: 'Antwort C',
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
                validator: (val) =>
                    val.isEmpty ? 'Antwort wird benötigt' : null,
                onSaved: (val) => newFragen.antwortC = val,
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Geben Sie hier Ihre vierte Antwortmöglichkeit ein',
                  labelText: 'Antwort D',
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
                validator: (val) =>
                    val.isEmpty ? 'Antwort wird benötigt' : null,
                onSaved: (val) => newFragen.antwortD = val,
              ),
              new FormField(
                builder: (FormFieldState state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Zutreffende Antwort',
                    ),
                    isEmpty: _rAntwort == '',
                    child: new DropdownButtonHideUnderline(
                      child: new DropdownButton(
                        value: _rAntwort,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            newFragen.richtigeAntwort = newValue;
                            _rAntwort = newValue;
                            state.didChange(newValue);
                          });
                        },
                        items: _rAntworten.map((String value) {
                          return new DropdownMenuItem(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
                validator: (val) {
                  return val != ''
                      ? null
                      : 'Bitte wählen Sie die zutreffende Antwort';
                },
              ),
              buildSubmit(),
//              startButton(context, "zurück zu home", Colors.lime),//vorläufig zurück zu home -- andere Lösung finden
            ],
          ),
        ),
      ),
    );
  }

  Container buildSubmit() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 50.0,
        horizontal: 20.0,
      ),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.lime,
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: const Text(
            'Einreichen',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        onPressed: _submitForm,
      ),
    );
  }
}

Widget startButton(context, text, backgroundColor) {
  return Padding(
    padding: EdgeInsets.all(
      20.0,
    ),
    child: InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              MyBottomNavigationBar(), //Themenbereich wählen Seite
        ));
      },
      child: Material(
        color: backgroundColor,
        elevation: 10.0,
        borderRadius: BorderRadius.circular(
          10.0,
        ),
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
              ),
              Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}