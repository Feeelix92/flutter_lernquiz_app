import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
          Icon(Icons.menu),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset('assets/img/bild_home.jpg'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(currentIndex: 1, items: [
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
