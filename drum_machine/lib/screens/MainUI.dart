import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:audio_recorder/audio_recorder.dart';
import '../SQLite.dart';
import 'Sequencer.dart';
import 'dart:io' as io;


AudioCache player = AudioCache(prefix: 'audio/');
final MethodChannel _channel =
    MethodChannel('plugins.flutter.io/path_provider');

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
  String sound1 = "Kick.wav";
  String sound2 = "Snare.wav";
  String sound3 = "Snare2.wav";
  String sound4 = "Hihat2.wav";
  String sound5 = "Pad1.wav";
  String sound6 = "Pad2.wav";
  String sound7 = "Keys.wav";
  String sound8 = "Hihat.wav";
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
            image: AssetImage("assets/images/backgrd.JPG"), fit: BoxFit.cover),
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
            Pad(sound1, sequencer1, this, 0),
            Pad(sound2, sequencer2, this, 1),
            Pad(sound3, sequencer3, this, 2),
            Pad(sound4, sequencer4, this, 3),
            Pad(sound5, sequencer5, this, 4),
            Pad(sound6, sequencer6, this, 5),
            Pad(sound7, sequencer7, this, 6),
            Pad(sound8, sequencer8, this, 7),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            PlayButton(sequencer1,sequencer2,sequencer3,sequencer4,sequencer5,sequencer6,sequencer7,sequencer8,
                sound1,sound2,sound3,sound4,sound5,sound6,sound7,sound8),
            ResetButton(
                sequencer1,sequencer2,sequencer3,sequencer4,sequencer5,sequencer6,sequencer7,sequencer8,
                this,
                sound1,sound2,sound3,sound4,sound5,sound6,sound7,sound8),
            DatabaseContainer(sequencer1, sequencer2, sequencer3, sequencer4,
                sequencer5, sequencer6, sequencer7, sequencer8, this, id),
          ],
        )
        //],
      ]),
    ); //);
  }
}

initDatabase() {
  if (path == null) {
    getPath();
  }
}

class Pad extends StatelessWidget {
  final _sound;
  final _sequencer;
  final _MainState parent;
  final recButtonId;

  Pad(this._sound, this._sequencer, this.parent, this.recButtonId);

  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: <Widget>[
        RaisedButton(
            padding: EdgeInsets.zero,
            splashColor: Colors.transparent,
            highlightColor: Colors.lightBlue,
            onPressed: () {},
            child: GestureDetector(
                onTapDown: (_) => onTapDownPlay(_sound),
                onLongPress: () {
                  _navigation(context, _sequencer);
                },
                child: Container(
                  color: Colors.white12,
                  child: Center(
                    child: Text(_sound.replaceAll(RegExp('.wav'), ''),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16)),
                  ),
                ))),
        RecButton(parent, recButtonId),
      ]),
    );
  }
}

onTapDownPlay(_sound) {
  if (_sound.contains('REC')) {
    String recordingPath =
        '/storage/emulated/0/Android/data/com.example.drum_machine/files/$_sound.wav';
    AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
    audioPlayer.play(recordingPath, isLocal: true, volume: 1.0);
  } else {
    player.play(_sound, volume: 1.0);
  }
}

class RecButton extends StatefulWidget {
  final parent;
  final recButtonId;

  RecButton(this.parent, this.recButtonId);
  _RecState createState() => _RecState();
}

class _RecState extends State<RecButton> {
  List rec = List<dynamic>.filled(8, 1);
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Container(
            decoration: BoxDecoration(border: Border.all(width: 1)),
            height: 30,
            width: 34,
            child: GestureDetector(
                onLongPress: () {
                  startRecord();
                },
                onLongPressUp: () {
                  stopRecord();
                },
                onDoubleTap: () {
                  changeSound(widget.parent, widget.recButtonId, rec);
                },
                child: Padding(
                    padding: EdgeInsets.all(2.5),
                    child: FloatingActionButton(
                      onPressed: () => {},
                      heroTag: null,
                      backgroundColor: Colors.red,
                    )))));
  }
}

startRecord() async {
  int rec = 1;
  if (await AudioRecorder.hasPermissions) {
    path = await getExternalStorageDirectory();
    if (await io.File(path + '/REC$rec.wav').exists()) {
      int add = 1;
      while (await io.File(path + '/REC$rec.wav').exists()) {
        rec++;
        add++;
      }
      infoToaster("Recording started...");
      await AudioRecorder.start(
          path: '$path/REC$add', audioOutputFormat: AudioOutputFormat.WAV);
    } else {
      infoToaster("Recording started...");
      await AudioRecorder.start(
          path: '$path/REC$rec', audioOutputFormat: AudioOutputFormat.WAV);
    }
  } else {
    infoToaster("ERROR: Permission denied from the settings");
  }
}

stopRecord() async {
  Recording recording = await AudioRecorder.stop();
  String recName = (recording.path
      .replaceAll(RegExp(await getExternalStorageDirectory() + '/'), ''));
  infoToaster("Saved as $recName");
  print(
      "Path : ${recording.path},  Format : ${recording.audioOutputFormat},  Duration : ${recording.duration},  Extension : ${recording.extension},");
}

changeSound(parent, recButtonId, rec) async {
  String path = '';
  if (path == '') {
    path = await getExternalStorageDirectory();
  }
  loopSounds(parent, path, recButtonId, rec);
}

loopSounds(parent, path, i, rec) async {
  if (await io.File(path + '/REC' + rec[i].toString() + '.wav').exists()) {
    parent.setState(() {
      switch (i) {
        case 0:{
            parent.sound1 = 'REC' + rec[i].toString();
          }break;
        case 1:{
            parent.sound2 = 'REC' + rec[i].toString();
          }break;
        case 2:{
            parent.sound3 = 'REC' + rec[i].toString();
          }break;
        case 3:{
            parent.sound4 = 'REC' + rec[i].toString();
          }break;
        case 4:{
            parent.sound5 = 'REC' + rec[i].toString();
          }break;
        case 5:{
            parent.sound6 = 'REC' + rec[i].toString();
          }break;
        case 6:{
            parent.sound7 = 'REC' + rec[i].toString();
          }break;
        case 7:{
            parent.sound8 = 'REC' + rec[i].toString();
          }break;
      }
    });
    rec[i]++;
  } else {
    parent.setState(() {
      switch (i) {
        case 0:{
            parent.sound1 = "Kick.wav";
            rec[i] = 1;
          }break;
        case 1:{
            parent.sound2 = "Snare.wav";
            rec[i] = 1;
          } break;
        case 2:{
            parent.sound3 = "Snare2.wav";
            rec[i] = 1;
          }break;
        case 3:{
            parent.sound4 = "Hihat.wav";
            rec[i] = 1;
          }break;
        case 4:{
            parent.sound5 = "Pad1.wav";
            rec[i] = 1;
          }break;
        case 5:{
            parent.sound6 = "Pad2.wav";
            rec[i] = 1;
          }break;
        case 6:{
            parent.sound7 = "Keys.wav";
            rec[i] = 1;
          }break;
        case 7:{
            parent.sound8 = "Hihat2.wav";
            rec[i] = 1;
          }break;
      }
    });
  }
}

//path = 'storage/emulated/0/Android/data/com.example.drum_machine/files'
Future<String> getExternalStorageDirectory() async {
  final String path =
      await _channel.invokeMethod<String>('getStorageDirectory');
  if (path == null) {
    return null;
  }
  return path;
}

_navigation(BuildContext context, _sequencer) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Sequencer(_sequencer)),
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
              SaveButton(sequencer1, sequencer2, sequencer3, sequencer4,
                  sequencer5, sequencer6, sequencer7, sequencer8),
              LoadButton(parent, id),
              MinusButton(parent),
              DatabaseTextId(id),
              PlusButton(parent),
              DeleteButton(id),
            ]));
  }
}

class SaveButton extends StatelessWidget {
  final seq1;
  final seq2;
  final seq3;
  final seq4;
  final seq5;
  final seq6;
  final seq7;
  final seq8;

  SaveButton(this.seq1, this.seq2, this.seq3, this.seq4, this.seq5, this.seq6,
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
  checkId(pattern);
}

class LoadButton extends StatelessWidget {
  final _MainState parent;
  final id;
  LoadButton(this.parent, this.id);
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
    infoToaster("Loaded from slot $id");
  } else {
    infoToaster("Load failed: empty slot");
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

class DatabaseTextId extends StatelessWidget {
  final id;
  DatabaseTextId(this.id);
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
  deleteSlot(id);
}

//Play
class PlayButton extends StatelessWidget {
  final sequencer1,sequencer2,sequencer3,sequencer4,sequencer5,sequencer6,sequencer7,sequencer8;
  final sound1,sound2,sound3,sound4,sound5,sound6,sound7,sound8;

  PlayButton(
      this.sequencer1,this.sequencer2,this.sequencer3,this.sequencer4,this.sequencer5,this.sequencer6,this.sequencer7,this.sequencer8,
      this.sound1,this.sound2,this.sound3,this.sound4,this.sound5,this.sound6,this.sound7,this.sound8);

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
            onPressed: () => play(
                sequencer1,sequencer2,sequencer3,sequencer4,sequencer5,sequencer6,sequencer7,sequencer8,
                sound1,sound2,sound3,sound4,sound5,sound6,sound7,sound8),
            child: Icon(
              Icons.play_circle_outline,
              color: Colors.black87,
              size: 30.0,
            ),
          ),
        )));
  }
}

play (
    sequencer1,sequencer2,sequencer3,sequencer4,sequencer5,sequencer6,sequencer7,sequencer8,
    sound1,sound2,sound3,sound4,sound5,sound6,sound7,sound8) async{
  var index = 1;
  String path = await getExternalStorageDirectory();
  String s1 = "$path/$sound1.wav";
  String s2 = "$path/$sound2.wav";
  String s3 = "$path/$sound3.wav";
  String s4 = "$path/$sound4.wav";
  String s5 = "$path/$sound5.wav";
  String s6 = "$path/$sound6.wav";
  String s7 = "$path/$sound7.wav";
  String s8 = "$path/$sound8.wav";

  Timer.run(() {
    if (sequencer1[0]) {
      if (sound1 == "Kick.wav") {
        player.play(sound1);
      } else {
        AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
        audioPlayer.play(s1, isLocal: true);
      }
    }
    if (sequencer2[0]) {
      if (sound2 == "Snare.wav") {
        player.play(sound2);
      } else {
        AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
        audioPlayer.play(s2, isLocal: true);
      }
    }
    if (sequencer3[0]) {
      if (sound3 == "Snare2.wav") {
        player.play(sound3);
      } else {
        AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
        audioPlayer.play(s3, isLocal: true);
      }
    }
    if (sequencer4[0]) {
      if (sound4 == "Hihat2.wav") {
        player.play(sound4);
      } else {
        AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
        audioPlayer.play(s4, isLocal: true);
      }
    }
    if (sequencer5[0]) {
      if (sound5 == "Pad1.wav") {
        player.play(sound5);
      } else {
        AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
        audioPlayer.play(s5, isLocal: true);
      }
    }
    if (sequencer6[0]) {
      if (sound6 == "Pad2.wav") {
        player.play(sound6);
      } else {
        AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
        audioPlayer.play(s6, isLocal: true);
      }
    }
    if (sequencer7[0]) {
      if (sound7 == "Keys.wav") {
        player.play(sound7);
      } else {
        AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
        audioPlayer.play(s7, isLocal: true);
      }
    }
    if (sequencer8[0]) {
      if (sound8 == "Hihat.wav") {
        player.play(sound8);
      } else {
        AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
        audioPlayer.play(s8, isLocal: true);
      }
    }
  });

  Timer.periodic(Duration(milliseconds: 250), (timer) {
    if (sequencer1[index]) {
      if (sound1 == "Kick.wav") {
        player.play(sound1);
      } else {
        AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
        audioPlayer.play(s1, isLocal: true);
      }
    }
    if (sequencer2[index]) {
      if (sound2 == "Snare.wav") {
        player.play(sound2);
      } else {
        AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
        audioPlayer.play(s2, isLocal: true);
      }
    }
    if (sequencer3[index]) {
      if (sound3 == "Snare2.wav") {
        player.play(sound3);
      } else {
        AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
        audioPlayer.play(s3, isLocal: true);
      }
    }
    if (sequencer4[index]) {
      if (sound4 == "Hihat2.wav") {
        player.play(sound4);
      } else {
        AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
        audioPlayer.play(s4, isLocal: true);
      }
    }
    if (sequencer5[index]) {
      if (sound5 == "Pad1.wav") {
        player.play(sound5);
      } else {
        AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
        audioPlayer.play(s5, isLocal: true);
      }
    }
    if (sequencer6[index]) {
      if (sound6 == "Pad2.wav") {
        player.play(sound6);
      } else {
        AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
        audioPlayer.play(s6, isLocal: true);
      }
    }
    if (sequencer7[index]) {
      if (sound7 == "Keys.wav") {
        player.play(sound7);
      } else {
        AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
        audioPlayer.play(s7, isLocal: true);
      }
    }
    if (sequencer8[index]) {
      if (sound8 == "Hihat.wav") {
        player.play(sound8);
      } else {
        AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
        audioPlayer.play(s8, isLocal: true);
      }
    }
    index++;
    if (index == 32) {
      timer.cancel();
    }
  });
}

class ResetButton extends StatelessWidget {
  final sequencer1,sequencer2,sequencer3,sequencer4,sequencer5,sequencer6,sequencer7,sequencer8;
  final _MainState parent;
  final sound1, sound2, sound3, sound4, sound5, sound6, sound7, sound8;

  ResetButton(
    this.sequencer1,this.sequencer2,this.sequencer3,this.sequencer4,this.sequencer5,this.sequencer6,this.sequencer7,this.sequencer8,
    this.parent,
    this.sound1,this.sound2,this.sound3,this.sound4,this.sound5,this.sound6,this.sound7,this.sound8,
  );

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
          onPressed: () => reset(sequencer1, sequencer2, sequencer3, sequencer4,
              sequencer5, sequencer6, sequencer7, sequencer8, parent),
          child: GestureDetector(
            onLongPress: () {
              resetSounds(parent, sound1, sound2, sound3, sound4, sound5,
                  sound6, sound7, sound8);
            },
            child: Text("Reset"),
          ),
        ))));
  }
}

resetSounds(
    parent, sound1, sound2, sound3, sound4, sound5, sound6, sound7, sound8) {
  parent.setState(() {
    parent.sound1 = "Kick.wav";
    parent.sound2 = "Snare.wav";
    parent.sound3 = "Snare2.wav";
    parent.sound4 = "Hihat2.wav";
    parent.sound5 = "Pad1.wav";
    parent.sound6 = "Pad2.wav";
    parent.sound7 = "Keys.wav";
    parent.sound8 = "Hihat.wav";
  });
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

infoToaster(msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white70,
      fontSize: 16.0);
}

