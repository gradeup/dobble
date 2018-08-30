import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gradeup_dobble/user.dart';


class CreateGame extends StatefulWidget {
  CreateGame();

  final String title = 'Join Game';

  @override
  _CreateGameState createState() => new _CreateGameState();
}

class _CreateGameState extends State<CreateGame> {
// StreamController<places.Place> placesStreamController;
  String password;
  List<String> userIds = [];
  DatabaseReference _gameRef;

  @override
  initState() {
    super.initState();
    //userIds = [];
    _saveGameData();
  }

  _saveGameData() {
    this._gameRef = FirebaseDatabase.instance.reference().child('game');
    _gameRef.onChildAdded.listen((Event event) {
      Map usersMap = Map.from(event.snapshot.value['users']);
      print("123");
      setState(() {
        userIds = usersMap.keys.toList().cast<String>();
      });
    });
    _gameRef.child('dodo').child('users').child(User.id).set(true);
  }

  _startGame() async {
    Navigator.pushNamed(context, '/startgame');
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> widget=[];
    List<Widget> widgets = userIds.map((userId) => new UserWidget(userId))
        .toList();
    widget.addAll(widgets);
    widget.add(new RaisedButton(onPressed: () {},
      child: Text("Start"),));
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Your game pass is dodo"),
        ),
        body:
        new ListView(
          children: widget,
//              children: userIds.map((userId) => new UserWidget(userId)).toList(),

        )

    );
  }


}

class UserWidget extends StatelessWidget {
  String name;

  UserWidget(this.name);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(this.name),
    );
  }
}