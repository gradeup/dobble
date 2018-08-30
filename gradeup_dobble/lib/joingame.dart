import 'package:flutter/material.dart';
import 'package:gradeup_dobble/user.dart';


class JoinGame extends StatefulWidget {
  JoinGame();
  final String title = 'Join Game';
  @override
  _JoinGameState createState() => new _JoinGameState();
}


class _JoinGameState extends State<JoinGame> {
// StreamController<places.Place> placesStreamController;
  String password;
  @override
  initState() {
    super.initState();
  }

  _checkPassword() async {
    debugPrint(this.password);
    if (this.password == 'dodo') {
      Navigator.pushNamed(context, '/creategame');
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Enter Join Code"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new TextField(
              decoration: new InputDecoration(labelText: "Join Code"),
              keyboardType: TextInputType.text,
              onChanged: (String value) {
                this.password = value;
              },
            ),
            RaisedButton(
              child: Text('Join'),
              onPressed: _checkPassword,
            )
          ],
        ),
      ),

    );
  }


}