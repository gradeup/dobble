import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';


Future<void> main() async {
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'db2',
    options: const FirebaseOptions(
      googleAppID: '1:995601114367:android:dd4da2546484e24c',
      apiKey: 'AIzaSyCZ_MJLRymXCnbdqPrTQnwNsK9j2CYDfIc',
      databaseURL: 'https://gradeup-dobble.firebaseio.com/',
    ),
  );
  runApp(new MaterialApp(
    home: new MyHomePage(app:app),
  ));
}

class User {
  String name;
  User (String name) {
    this.name = name;
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({this.app});
  final FirebaseApp app;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  DatabaseReference _userRef;
  String userInput;
  @override
  void initState() {
    super.initState();
    // Demonstrates configuring to the database using a file
    _userRef = FirebaseDatabase.instance.reference().child('users');

  }



  Future<Null>  _addUser() async {
      await _userRef.push().set(<String, String>{
        'name': this.userInput
      });
//      Navigator.pushNamed(context, '/homepage');
  }



  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text("Test"),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug paint" (press "p" in the console where you ran
          // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
          // window in IntelliJ) to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new TextField(
              decoration: new InputDecoration(labelText: "Enter your name"),
              keyboardType: TextInputType.text,
              onChanged: (String value) {
                this.userInput = value;
              },
            ),
            RaisedButton(
                child: Text('Next'),
                onPressed: _addUser,
            )
          ],
        ),
      ),

    );
  }
}
