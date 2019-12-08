import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import '../SQLite.dart';
import 'Sequencer.dart';

AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
AudioCache player = AudioCache(prefix: 'audio/');

class MainUI extends StatefulWidget {
  _MainState createState() => _MainState();
}

class _MainState extends State<MainUI> {
  List sequencer1 = List<dynamic>.filled(32, false);
  List sequencer2 = List<dynamic>.filled(32, false);
  List sequencer3 = List<dynamic>.filled(32, false);
  List sequencer4 = List<dynamic>.filled(32, false);
  List sequencer5 = List<dynamic>.filled(32, false);
  List sequencer6 = List<dynamic>.filled(32, false);
  List sequencer7 = List<dynamic>.filled(32, false);
  List sequencer8 = List<dynamic>.filled(32, false);
  int id = 1;
  @override
  Widget build(BuildContext context) {
    initDatabase();
    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height / 0.62;
    final double itemWidth = size.width;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/backgrd.jpg"), fit: BoxFit.cover),
      ),
      child: ListView(shrinkWrap: false, children: <Widget>[
        GridView.count(
          shrinkWrap: true,
          primary: true,
          padding: const EdgeInsets.fromLTRB(40, 30, 40, 15),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 4,
          childAspectRatio: itemWidth / itemHeight,
          children: <Widget>[
            Pad("Kick", "Kick.wav", 1, sequencer1),
            Pad("Snare", "Snare.wav", 2, sequencer2),
            Pad("Snare", "Snare2.wav", 3, sequencer3),
            Pad("Hi-hat", "Hihat2.wav", 4, sequencer4),
            Pad("Clap", "Clap.wav", 5, sequencer5),
            Pad("Bass", "Bass.wav", 6, sequencer6),
            Pad("Keys", "Keys.wav", 7, sequencer7),
            Pad("Hi-hat", "Hihat.wav", 8, sequencer8),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            PlayButton(sequencer1, sequencer2, sequencer3, sequencer4,
                sequencer5, sequencer6, sequencer7, sequencer8),
            ResetButton(sequencer1, sequencer2, sequencer3, sequencer4,
                sequencer5, sequencer6, sequencer7, sequencer8, this),
            DatabaseContainer(sequencer1, sequencer2, sequencer3, sequencer4,
                sequencer5, sequencer6, sequencer7, sequencer8, this, id),
          ],
        )
        //],
      ]),
    ); //);
  }
}

//Pad
class Pad extends StatelessWidget {
  final _text;
  final _localPath;
  final _soundNumber;
  final _sequencer;

  Pad(this._text, this._localPath, this._soundNumber, this._sequencer);

  Widget build(BuildContext context) {
    player.loadAll([
      'Bass.wav',
      'Clap.wav',
      'Hihat.wav',
      'Hihat2.wav',
      'Keys.wav',
      'Kick.wav',
      'Snare.wav',
      'Snare2.wav',
    ]);
    return RaisedButton(
        padding: EdgeInsets.zero,
        splashColor: Colors.transparent,
        highlightColor: Colors.lightBlue,
        onPressed: () {},
        child: GestureDetector(
            onTapDown: (_) => player.play(_localPath, volume: 1.0),
            onLongPress: () {
              _navigation(context, _soundNumber, _sequencer);
            },
            child: Container(
                color: Colors.white12,
                child: Center(
                  child: Text(_text,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16)),
                ))));
  }
}

_navigation(BuildContext context, _soundNumber, _sequencer) async {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => Sequencer(_soundNumber, _sequencer)),
  );
}

class DatabaseContainer extends StatelessWidget {
  final List sequencer1;
  final List sequencer2;
  final List sequencer3;
  final List sequencer4;
  final List sequencer5;
  final List sequencer6;
  final List sequencer7;
  final List sequencer8;
  final _MainState parent;
  final int id;

  DatabaseContainer(
      this.sequencer1,
      this.sequencer2,
      this.sequencer3,
      this.sequencer4,
      this.sequencer5,
      this.sequencer6,
      this.sequencer7,
      this.sequencer8,
      this.parent,
      this.id);
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
    return Container(
        width: itemWidth,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black), boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: new Offset(3.0, 3.0),
          )
        ]),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ExportButton(sequencer1, sequencer2, sequencer3, sequencer4,
                  sequencer5, sequencer6, sequencer7, sequencer8),
              Fetch(parent, id),
              MinusButton(parent),
              TextId(id),
              PlusButton(parent),
              DeleteButton(id),
            ]));
  }
}

initDatabase() {
  if (path == null) {
    getPath();
  }
}

class ExportButton extends StatelessWidget {
  final seq1;
  final seq2;
  final seq3;
  final seq4;
  final seq5;
  final seq6;
  final seq7;
  final seq8;

  ExportButton(this.seq1, this.seq2, this.seq3, this.seq4, this.seq5, this.seq6,
      this.seq7, this.seq8);

  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 65,
      child: FlatButton(
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black87)),
        color: Colors.grey,
        disabledColor: Colors.grey,
        onPressed: () => export(seq1, seq2, seq3, seq4, seq5, seq6, seq7, seq8),
        child: Text("Save",
            style: TextStyle(
              color: Colors.black,
            )),
      ),
    ));
  }
}

export(seq1, seq2, seq3, seq4, seq5, seq6, seq7, seq8) {
  String pattern =
      '"seq1": $seq1, "seq2": $seq2, "seq3": $seq3, "seq4": $seq4, "seq5": $seq5, "seq6": $seq6, "seq7": $seq7, "seq8": $seq8';
  //insert(pattern);
  table(pattern);
  print(pattern);
  print(path);
}

saveToaster(id) {
  Fluttertoast.showToast(
      msg: "Saved on slot $id",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white70,
      fontSize: 16.0);
}

saveFailedToaster() {
  Fluttertoast.showToast(
      msg: "No free slots for saving",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white70,
      fontSize: 16.0);
}

class Fetch extends StatelessWidget {
  final _MainState parent;
  final id;
  Fetch(this.parent, this.id);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 65,
      child: FlatButton(
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black87)),
        color: Colors.grey,
        disabledColor: Colors.grey,
        onPressed: () => fetchSet(this.parent, this.id),
        child: Text("Load",
            style: TextStyle(
              color: Colors.black,
            )),
      ),
    ));
  }
}

fetchSet(parent, id) async {
  List<Map> dbData = await fetch(parent.id);
  if (dbData.length != 0) {
    var data = dbData[0].toString();
    var temp = data.replaceAll(RegExp('pattern:'), '');
    setParent(parent, temp);
  } else {
    loadFailToaster();
  }
}

setParent(parent, temp) {
  Map<String, dynamic> json = jsonDecode(temp);
  List<dynamic> temp1 = json['seq1'];
  List<dynamic> temp2 = json['seq2'];
  List<dynamic> temp3 = json['seq3'];
  List<dynamic> temp4 = json['seq4'];
  List<dynamic> temp5 = json['seq5'];
  List<dynamic> temp6 = json['seq6'];
  List<dynamic> temp7 = json['seq7'];
  List<dynamic> temp8 = json['seq8'];
  parent.setState(() {
    parent.sequencer1 = temp1;
    parent.sequencer2 = temp2;
    parent.sequencer3 = temp3;
    parent.sequencer4 = temp4;
    parent.sequencer5 = temp5;
    parent.sequencer6 = temp6;
    parent.sequencer7 = temp7;
    parent.sequencer8 = temp8;
  });
}

loadFailToaster() {
  Fluttertoast.showToast(
      msg: "Load failed: empty slot",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white70,
      fontSize: 16.0);
}

class MinusButton extends StatelessWidget {
  final _MainState parent;
  MinusButton(this.parent);
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 40,
      child: FlatButton(
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black87)),
        color: Colors.white30,
        disabledColor: Colors.white30,
        onPressed: () => minus(parent),
        child: Text("-",
            style: TextStyle(
              color: Colors.black,
            )),
      ),
    ));
  }
}

minus(parent) {
  if (parent.id <= 10 && parent.id > 1) {
    parent.setState(() {
      parent.id = parent.id - 1;
    });
  }
}

class TextId extends StatelessWidget {
  final id;
  TextId(this.id);
  Widget build(BuildContext context) {
    return Container(
        height: 36,
        width: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black87),
          color: Colors.white30,
        ),
        child: Material(
            type: MaterialType.transparency,
            child: Center(
              child: Text(
                '$id',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            )));
  }
}

class PlusButton extends StatelessWidget {
  final _MainState parent;
  PlusButton(this.parent);
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 40,
      child: FlatButton(
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black87)),
        color: Colors.white30,
        disabledColor: Colors.white30,
        onPressed: () => plus(parent),
        child: Text("+",
            style: TextStyle(
              color: Colors.black,
            )),
      ),
    ));
  }
}

plus(parent) {
  if (parent.id < 10 && parent.id > 0) {
    parent.setState(() {
      parent.id = parent.id + 1;
    });
  }
}

class DeleteButton extends StatelessWidget {
  final id;
  DeleteButton(this.id);
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 75,
      child: FlatButton(
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black87)),
        color: Colors.grey,
        disabledColor: Colors.grey,
        onPressed: () => delete(id),
        child: Text("Delete",
            style: TextStyle(
              color: Colors.black,
            )),
      ),
    ));
  }
}

delete(id) {
  deleteTable(id);
}

//Play
class PlayButton extends StatelessWidget {
  final sequencer1;
  final sequencer2;
  final sequencer3;
  final sequencer4;
  final sequencer5;
  final sequencer6;
  final sequencer7;
  final sequencer8;

  PlayButton(this.sequencer1, this.sequencer2, this.sequencer3, this.sequencer4,
      this.sequencer5, this.sequencer6, this.sequencer7, this.sequencer8);

  Widget build(BuildContext context) {
    return Container(
        width: 80,
        child: Center(
            child: Container(
          child: FlatButton(
            shape:
                RoundedRectangleBorder(side: BorderSide(color: Colors.black87)),
            color: Colors.white12,
            disabledColor: Colors.white12,
            onPressed: () => play(sequencer1, sequencer2, sequencer3,
                sequencer4, sequencer5, sequencer6, sequencer7, sequencer8),
            child: Icon(
              Icons.play_circle_outline,
              color: Colors.black87,
              size: 30.0,
            ),
          ),
        )));
  }
}

play(sequencer1, sequencer2, sequencer3, sequencer4, sequencer5, sequencer6,
    sequencer7, sequencer8) {
  var index = 1;

  Timer.run(() {
    if (sequencer1[0]) {
      player.play("Kick.wav");
    }
    if (sequencer2[0]) {
      player.play("Snare.wav");
    }
    if (sequencer3[0]) {
      player.play("Snare2.wav");
    }
    if (sequencer4[0]) {
      player.play("Hihat2.wav");
    }
    if (sequencer5[0]) {
      player.play("Clap.wav");
    }
    if (sequencer6[0]) {
      player.play("Bass.wav");
    }
    if (sequencer7[0]) {
      player.play("Keys.wav");
    }
    if (sequencer8[0]) {
      player.play("Hihat.wav");
    }
  });

  Timer.periodic(Duration(milliseconds: 250), (timer) {
    if (sequencer1[index]) {
      player.play("Kick.wav");
    }
    if (sequencer2[index]) {
      player.play("Snare.wav");
    }
    if (sequencer3[index]) {
      player.play("Snare2.wav");
    }
    if (sequencer4[index]) {
      player.play("Hihat2.wav");
    }
    if (sequencer5[index]) {
      player.play("Clap.wav");
    }
    if (sequencer6[index]) {
      player.play("Bass.wav");
    }
    if (sequencer7[index]) {
      player.play("Keys.wav");
    }
    if (sequencer8[index]) {
      player.play("Hihat.wav");
    }
    index++;
    if (index == 32) {
      timer.cancel();
    }
  });
}

//Reset
class ResetButton extends StatelessWidget {
  final sequencer1;
  final sequencer2;
  final sequencer3;
  final sequencer4;
  final sequencer5;
  final sequencer6;
  final sequencer7;
  final sequencer8;
  final _MainState parent;

  ResetButton(
      this.sequencer1,
      this.sequencer2,
      this.sequencer3,
      this.sequencer4,
      this.sequencer5,
      this.sequencer6,
      this.sequencer7,
      this.sequencer8,
      this.parent);

  Widget build(BuildContext context) {
    return Container(
        width: 80,
        child: Center(
            child: Container(
          child: FlatButton(
            shape:
                RoundedRectangleBorder(side: BorderSide(color: Colors.black87)),
            color: Colors.white12,
            disabledColor: Colors.white12,
            onPressed: () => reset(
                sequencer1,
                sequencer2,
                sequencer3,
                sequencer4,
                sequencer5,
                sequencer6,
                sequencer7,
                sequencer8,
                parent),
            child: Text("Reset"),
          ),
        )));
  }
}

reset(sequencer1, sequencer2, sequencer3, sequencer4, sequencer5, sequencer6,
    sequencer7, sequencer8, parent) {
  parent.setState(() {
    parent.sequencer1 = List<dynamic>.filled(32, false);
    parent.sequencer2 = List<dynamic>.filled(32, false);
    parent.sequencer3 = List<dynamic>.filled(32, false);
    parent.sequencer4 = List<dynamic>.filled(32, false);
    parent.sequencer5 = List<dynamic>.filled(32, false);
    parent.sequencer6 = List<dynamic>.filled(32, false);
    parent.sequencer7 = List<dynamic>.filled(32, false);
    parent.sequencer8 = List<dynamic>.filled(32, false);
  });
}
