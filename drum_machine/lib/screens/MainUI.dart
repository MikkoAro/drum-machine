import 'package:flutter/material.dart';
import '../Pad.dart';

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
          padding: const EdgeInsets.fromLTRB(40, 15, 40, 5),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 4,
          childAspectRatio: 10 / 8.5,
          children: <Widget>[
            Pad("Kick", "Kick.wav", 1),
            Pad("Snare", "Snare.wav", 2),
            Pad("Snare", "Snare2.wav", 3),
            Pad("Hi-hat", "Hihat2.wav", 4),
            Pad("Clap", "Clap.wav", 5),
            Pad("Bass", "Bass.wav", 6),
            Pad("Keys", "Keys.wav", 7),
            Pad("Hi-hat", "Hihat.wav", 8),
          ],
        ),
        PlayButton(),
        //],
      ]),
    ); //);
  }
}
