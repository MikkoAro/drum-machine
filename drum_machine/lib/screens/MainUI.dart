import 'package:flutter/material.dart';
import '../Pad.dart';

var sequencer1 = List<bool>.filled(16, false);
var sequencer2 = List<bool>.filled(16, false);
var sequencer3 = List<bool>.filled(16, false);
var sequencer4 = List<bool>.filled(16, false);
var sequencer5 = List<bool>.filled(16, false);
var sequencer6 = List<bool>.filled(16, false);
var sequencer7 = List<bool>.filled(16, false);
var sequencer8 = List<bool>.filled(16, false);

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
            PlayButton(),
          ],
        )

        //],
      ]),
    ); //);
  }
}
