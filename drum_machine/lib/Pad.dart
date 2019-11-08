import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'screens/Sequencer.dart';
import 'dart:convert';
import 'dart:async';
import 'size_config.dart';

AudioCache player = AudioCache(prefix: 'audio/');
AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
var seq1;
var seq2;
var seq3;
var seq4;
var seq5;
var seq6;
var seq7;
var seq8;

class Pad extends StatelessWidget {
  final _text;
  final _localPath;
  final _soundNumber;
  Pad(this._text, this._localPath, this._soundNumber);

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
    ;
    return RaisedButton(
        padding: EdgeInsets.zero,
        splashColor: Colors.transparent,
        highlightColor: Colors.lightBlue,
        onPressed: () {},
        child: GestureDetector(
            onTapDown: (_) => player.play(_localPath, volume: 1.0),
            onLongPress: () {
              _navigation(context, _soundNumber);
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

class PlayButton extends StatelessWidget {
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
        child: Container(
      height: SizeConfig.blockSizeVertical * 10,
      width: SizeConfig.blockSizeHorizontal * 10,
      child: FlatButton(
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black87)),
        color: Colors.white12,
        disabledColor: Colors.white12,
        onPressed: () => play(),
        child: Text("Play",
            style: TextStyle(
              color: Colors.black,
            )),
      ),
    ));
  }
}

_navigation(BuildContext context, _soundNumber) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Sequencer(_soundNumber)),
  );
  parseData(result);
  print(result);
}

parseData(json) {
  var parsedJson = jsonDecode(json);
  seq1 = parsedJson['seq1'];
  seq2 = parsedJson['seq2'];
  seq3 = parsedJson['seq3'];
  seq4 = parsedJson['seq4'];
  seq5 = parsedJson['seq5'];
  seq6 = parsedJson['seq6'];
  seq7 = parsedJson['seq7'];
  seq8 = parsedJson['seq8'];
}

play() {
  var parsedSeq1 = json.decode(seq1);
  var parsedSeq2 = json.decode(seq2);
  var parsedSeq3 = json.decode(seq3);
  var parsedSeq4 = json.decode(seq4);
  var parsedSeq5 = json.decode(seq5);
  var parsedSeq6 = json.decode(seq6);
  var parsedSeq7 = json.decode(seq7);
  var parsedSeq8 = json.decode(seq8);
  var index = 1;

  Timer.run(() {
    if (parsedSeq1[0]) {
      player.play("Kick.wav");
    }
    if (parsedSeq2[0]) {
      player.play("Snare.wav");
    }
    if (parsedSeq3[0]) {
      player.play("Snare2.wav");
    }
    if (parsedSeq4[0]) {
      player.play("Hihat2.wav");
    }
    if (parsedSeq5[0]) {
      player.play("Clap.wav");
    }
    if (parsedSeq6[0]) {
      player.play("Bass.wav");
    }
    if (parsedSeq7[0]) {
      player.play("Keys.wav");
    }
    if (parsedSeq8[0]) {
      player.play("Hihat.wav");
    }
  });

  Timer.periodic(Duration(milliseconds: 250), (timer) {
    if (parsedSeq1[index]) {
      player.play("Kick.wav");
    }
    if (parsedSeq2[index]) {
      player.play("Snare.wav");
    }
    if (parsedSeq3[index]) {
      player.play("Snare2.wav");
    }
    if (parsedSeq4[index]) {
      player.play("Hihat2.wav");
    }
    if (parsedSeq5[index]) {
      player.play("Clap.wav");
    }
    if (parsedSeq6[index]) {
      player.play("Bass.wav");
    }
    if (parsedSeq7[index]) {
      player.play("Keys.wav");
    }
    if (parsedSeq8[index]) {
      player.play("Hihat.wav");
    }
    index++;
    if (index == 16) {
      timer.cancel();
    }
  });
}
