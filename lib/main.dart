import 'package:flutter/material.dart';
import 'package:flutter_lernquiz_app/screens/home_screen.dart';
import 'package:flutter_lernquiz_app/screens/loading_screen.dart';
import 'package:flutter_lernquiz_app/screens/neue_fragen_form_screen.dart';
import 'package:flutter_lernquiz_app/screens/thema_waehlen_screen.dart';
import 'package:flutter_lernquiz_app/screens/themen_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: LoadingScreen(),
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {

  int _currentIndex = 1;
  final List<Widget> _children = [
    NeueFragenFormScreen(),
    HomeScreen(),
    ThemenScreen(),
  ];
  void onTappedBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children [_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTappedBar,
          currentIndex: _currentIndex,
          items: [
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
        )
      ]),
    );
  }
}
