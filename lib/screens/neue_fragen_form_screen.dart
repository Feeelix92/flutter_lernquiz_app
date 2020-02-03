import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lernquiz_app/main.dart';
import 'package:flutter_lernquiz_app/model/neueFragen.dart';
//import 'package:flutter_lernquiz_app/lib/model/neueFragen.dart'; //funktoniert leider noch nicht

Fragen newFragen = new Fragen();

class NeueFragenFormScreen extends StatefulWidget {
  @override
  _NeueFragenFormScreenState createState() => _NeueFragenFormScreenState();
}

class _NeueFragenFormScreenState extends State<NeueFragenFormScreen> {
  //@override

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<String> _rAntworten = <String>['', 'A', 'B', 'C', 'D'];
  String _rAntwort = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          autovalidate: true,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              new TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Geben Sie hier Ihre neue Frage ein',
                  labelText: 'Frage',
                ),
//                  inputFormatters: [new LengthLimitingTextInputFormatter(50)], //funktioniert noch nicht
                validator: (val) => val.isEmpty ? 'Frage wird benötigt' : null,
//                onSaved: (val) => Fragen.frage = val,
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Geben Sie hier Ihre erste Antwortmöglichkeit ein',
                  labelText: 'Antwort A',
                ),
                validator: (val) =>
                    val.isEmpty ? 'Antwort wird benötigt' : null,
//                    onSaved: (val) => Fragen.antwortA = val,
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Geben Sie hier Ihre zweite Antwortmöglichkeit ein',
                  labelText: 'Antwort B',
                ),
                validator: (val) =>
                    val.isEmpty ? 'Antwort wird benötigt' : null,
//                    onSaved: (val) => Fragen.antwortB = val,
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Geben Sie hier Ihre dritte Antwortmöglichkeit ein',
                  labelText: 'Antwort C',
                ),
                validator: (val) =>
                    val.isEmpty ? 'Antwort wird benötigt' : null,
//                    onSaved: (val) => Fragen.antwortC = val,
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Geben Sie hier Ihre vierte Antwortmöglichkeit ein',
                  labelText: 'Antwort D',
                ),
                validator: (val) =>
                    val.isEmpty ? 'Antwort wird benötigt' : null,
//                    onSaved: (val) => Fragen.antwortD = val,
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
                            newFragen.richtigeAntwort =
                                newValue; //https://codingwithjoe.com/building-forms-with-flutter/  ab Punkt "Submitting the Form"
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
              new Container(
                padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                child: new RaisedButton(
                  child: const Text('Einreichen'),
                  onPressed: null,
                ),
              ),
              startButton(context, "Speichern & Weiter", Colors.lime),
            ],
          ),
        ),
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
