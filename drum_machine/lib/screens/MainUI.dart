import 'package:flutter/material.dart';
import '../Pad.dart';

var testSequencer1 = List<bool>.filled(16, false);
var testSequencer2 = List<bool>.filled(16, false);
var testSequencer3 = List<bool>.filled(16, false);
var testSequencer4 = List<bool>.filled(16, false);
var testSequencer5 = List<bool>.filled(16, false);
var testSequencer6 = List<bool>.filled(16, false);
var testSequencer7 = List<bool>.filled(16, false);
var testSequencer8 = List<bool>.filled(16, false);

class MainUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/backgrd.jpg"), fit: BoxFit.cover),
      ),
      child: ListView(shrinkWrap: false, children: <Widget>[
        GridView.count(
          shrinkWrap: true,
          primary: true,
          padding: const EdgeInsets.fromLTRB(40, 40, 40, 40),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 4,
          childAspectRatio: 10 / 8.5,
          children: <Widget>[
            Pad("Kick", "Kick.wav", 1, testSequencer1),
            Pad("Snare", "Snare.wav", 2, testSequencer2),
            Pad("Snare", "Snare2.wav", 3, testSequencer3),
            Pad("Hi-hat", "Hihat2.wav", 4, testSequencer4),
            Pad("Clap", "Clap.wav", 5, testSequencer5),
            Pad("Bass", "Bass.wav", 6, testSequencer6),
            Pad("Keys", "Keys.wav", 7, testSequencer7),
            Pad("Hi-hat", "Hihat.wav", 8, testSequencer8),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            PlayButton(),
          ],
        )

        //],
      ]),
    ); //);
  }
}
