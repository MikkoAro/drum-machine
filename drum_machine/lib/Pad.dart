import 'package:drum_machine/screens/MainUI.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'screens/Sequencer.dart';
import 'dart:async';
import 'size_config.dart';

AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
AudioCache player = AudioCache(prefix: 'audio/');

class Pad extends StatelessWidget {
  final _text;
  final _localPath;
  final _soundNumber;
  final _testSequencer;
  Pad(this._text, this._localPath, this._soundNumber, this._testSequencer);

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
              _navigation(context, _soundNumber, _testSequencer);
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

_navigation(BuildContext context, _soundNumber, _testSequencer) async {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => Sequencer(_soundNumber, _testSequencer)),
  );
}

play() {
  var index = 1;

  Timer.run(() {
    if (testSequencer1[0]) {
      player.play("Kick.wav");
    }
    if (testSequencer2[0]) {
      player.play("Snare.wav");
    }
    if (testSequencer3[0]) {
      player.play("Snare2.wav");
    }
    if (testSequencer4[0]) {
      player.play("Hihat2.wav");
    }
    if (testSequencer5[0]) {
      player.play("Clap.wav");
    }
    if (testSequencer6[0]) {
      player.play("Bass.wav");
    }
    if (testSequencer7[0]) {
      player.play("Keys.wav");
    }
    if (testSequencer8[0]) {
      player.play("Hihat.wav");
    }
  });

  Timer.periodic(Duration(milliseconds: 250), (timer) {
    if (testSequencer1[index]) {
      player.play("Kick.wav");
    }
    if (testSequencer2[index]) {
      player.play("Snare.wav");
    }
    if (testSequencer3[index]) {
      player.play("Snare2.wav");
    }
    if (testSequencer4[index]) {
      player.play("Hihat2.wav");
    }
    if (testSequencer5[index]) {
      player.play("Clap.wav");
    }
    if (testSequencer6[index]) {
      player.play("Bass.wav");
    }
    if (testSequencer7[index]) {
      player.play("Keys.wav");
    }
    if (testSequencer8[index]) {
      player.play("Hihat.wav");
    }
    index++;
    if (index == 16) {
      timer.cancel();
    }
  });
}
