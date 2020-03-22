import 'package:flutter/material.dart';
import 'package:hs_fulda/screens/home_screen.dart';
import 'package:hs_fulda/screens/question_type_select.dart';
import 'package:hs_fulda/screens/theme_select_screen.dart';
import 'package:hs_fulda/screens/loading_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.pinkAccent,
          textTheme: TextTheme(
            title: TextStyle(
                color: Colors.white
            ),
            subtitle: TextStyle(
                color: Colors.white
            ),
          ),
          fontFamily: "Montserrat",
          buttonColor: Colors.teal,
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              textTheme: ButtonTextTheme.primary
          )
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
    QuestionTypeSelect(),
    HomeScreen(),
    ThemeSelect(),
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
