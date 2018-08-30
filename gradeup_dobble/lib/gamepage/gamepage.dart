import 'package:flutter/material.dart';
import 'package:gradeup_dobble/user.dart';


class GamepageScreen extends StatefulWidget {
  GamepageScreen();

  final String title = 'Start Game';
  @override
  _GamepageScreenState createState() => new _GamepageScreenState();
}


class _GamepageScreenState extends State<GamepageScreen> {
// StreamController<places.Place> placesStreamController;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: Center(
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    child: Text('Create Game'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/creategame');
                    }),

                RaisedButton(
                    child: Text('Join Game'),
                    onPressed: () {
                      debugPrint(User.name);
                      debugPrint(User.id);
                      Navigator.pushNamed(context, '/joingame');
                    }),
// new HtmlView(data: html),
              ],
            ),
          ),
        )
    );
  }


}