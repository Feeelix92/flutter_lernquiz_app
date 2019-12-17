import 'package:flutter/material.dart';
import 'package:flutter_lernquiz_app/screens/home_screen.dart';

class ThemenScreen extends StatefulWidget {
  @override
  _ThemenScreenState createState() => _ThemenScreenState();
}

class _ThemenScreenState extends State<ThemenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Themen"),
        actions: <Widget>[
          Icon(Icons.menu),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            buildButton(context, "Multimediagrundlagen", HomeScreen()),
            buildButton(context, "Programmierung 1", HomeScreen()),
            buildButton(context, "Programmierung 2", HomeScreen()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(currentIndex: 2, items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.fiber_new),
          title: Text('neue Fragen'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.folder_open),
          title: Text('Themen'),
        ),
      ]),
    );
  }
}
Widget buildButton(BuildContext context, text, widget) {
  return RaisedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
      );
    },
    child: Text(text),
  );
}