import 'package:flutter/material.dart';
import '../StepSeq.dart';


var sound1Seq = List<bool>.filled(16, false);
var sound2Seq = List<bool>.filled(16, false);
var sound3Seq = List<bool>.filled(16, false);
var sound4Seq = List<bool>.filled(16, false);
var sound5Seq = List<bool>.filled(16, false);
var sound6Seq = List<bool>.filled(16, false);
var sound7Seq = List<bool>.filled(16, false);
var sound8Seq = List<bool>.filled(16, false);
var sound1 = 0;
var sound2 = 0;
var sound3 = 0;
var sound4 = 0;
var sound5 = 0;
var sound6 = 0;
var sound7 = 0;
var sound8 = 0;

class Sequencer extends StatelessWidget {
  final int _soundNumber;

  Sequencer(this._soundNumber);
  @override
  Widget build(BuildContext context) {
    passValue(_soundNumber);
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/backgrd.jpg"),
              fit: BoxFit.cover),
        ),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            GridView.count(
              shrinkWrap: true,
              primary: true,
              padding: const EdgeInsets.all(40),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 8,
              children: <Widget>[
                StepSeq(buttonId: 1),
                StepSeq(buttonId: 2),
                StepSeq(buttonId: 3),
                StepSeq(buttonId: 4),
                StepSeq(buttonId: 5),
                StepSeq(buttonId: 6),
                StepSeq(buttonId: 7),
                StepSeq(buttonId: 8),
                StepSeq(buttonId: 9),
                StepSeq(buttonId: 10),
                StepSeq(buttonId: 11),
                StepSeq(buttonId: 12),
                StepSeq(buttonId: 13),
                StepSeq(buttonId: 14),
                StepSeq(buttonId: 15),
                StepSeq(buttonId: 16),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black87)),
                  onPressed: () => _sendDataBack(context, _soundNumber),
                  child: Text("Back"),
                ),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black87)),
                    onPressed: () => _resetSequencer(_soundNumber),
                    child: Text(
                      "Reset",
                      style: new TextStyle(fontSize: 10.0),
                    )),
              ],
            ),
          ],
        ));
  }
}

void _sendDataBack(BuildContext context, int soundNumber) {
  String response =
      '{"seq1": "$sound1Seq", "seq2": "$sound2Seq", "seq3": "$sound3Seq", "seq4": "$sound4Seq", "seq5": "$sound5Seq", "seq6": "$sound6Seq", "seq7": "$sound7Seq", "seq8": "$sound8Seq"}';

  Navigator.pop(context, response);
}

_resetSequencer(soundNumber) {
  switch (soundNumber) {
    case 1:
      {
        sound1Seq = List<bool>.filled(16, false);
      }
      break;
    case 2:
      {
        sound2Seq = List<bool>.filled(16, false);
      }
      break;
    case 3:
      {
        sound3Seq = List<bool>.filled(16, false);
      }
      break;
    case 4:
      {
        sound4Seq = List<bool>.filled(16, false);
      }
      break;
    case 5:
      {
        sound5Seq = List<bool>.filled(16, false);
      }
      break;
    case 6:
      {
        sound6Seq = List<bool>.filled(16, false);
      }
      break;
    case 7:
      {
        sound7Seq = List<bool>.filled(16, false);
      }
      break;
    case 8:
      {
        sound8Seq = List<bool>.filled(16, false);
      }
      break;
  }
}