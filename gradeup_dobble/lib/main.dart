import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gradeup_dobble/creategame.dart';
import 'package:gradeup_dobble/gamepage/gamepage.dart';
import 'package:gradeup_dobble/joingame.dart';
import 'package:gradeup_dobble/user.dart';


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
    home: new MyApp(app:app),
  ));
}

class MyApp extends StatelessWidget {
  final FirebaseApp app;
  MyApp({this.app});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: 'Gradeup dobble',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => new MyHomePage(app:this.app),
        '/homepage': (context) => new GamepageScreen(),
        '/joingame': (context) => new JoinGame(),
        '/creategame': (context) => new CreateGame(),
      },
    );
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
  DatabaseReference _userRef;
  String userInput;
  @override
  void initState() {
    super.initState();
    _userRef = FirebaseDatabase.instance.reference().child('users');

  }

  Future<Null>  _addUser() async {
      DatabaseReference newUser = _userRef.push();
      await _userRef.child(newUser.key).set(<String, String>{
        'name': this.userInput
      });
      User.name = this.userInput;
      User.id = newUser.key;
      Navigator.pushNamed(context, '/homepage');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Gradeup Dobble"),
      ),
      body: new Center(
        child: new Column(
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
