import 'package:flutter/material.dart';

// SEQUENCER UI
class Sequencer extends StatelessWidget {
  final int _soundNumber;
  final List _testSequencer;
  Sequencer(this._soundNumber, this._testSequencer);
  @override
  Widget build(BuildContext context) {
    //passValue(_soundNumber);
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
                StepSeq(buttonId: 0, sound: _soundNumber, seq: _testSequencer),
                StepSeq(buttonId: 1, sound: _soundNumber, seq: _testSequencer),
                StepSeq(buttonId: 2, sound: _soundNumber, seq: _testSequencer),
                StepSeq(buttonId: 3, sound: _soundNumber, seq: _testSequencer),
                StepSeq(buttonId: 4, sound: _soundNumber, seq: _testSequencer),
                StepSeq(buttonId: 5, sound: _soundNumber, seq: _testSequencer),
                StepSeq(buttonId: 6, sound: _soundNumber, seq: _testSequencer),
                StepSeq(buttonId: 7, sound: _soundNumber, seq: _testSequencer),
                StepSeq(buttonId: 8, sound: _soundNumber, seq: _testSequencer),
                StepSeq(buttonId: 9, sound: _soundNumber, seq: _testSequencer),
                StepSeq(buttonId: 10, sound: _soundNumber, seq: _testSequencer),
                StepSeq(buttonId: 11, sound: _soundNumber, seq: _testSequencer),
                StepSeq(buttonId: 12, sound: _soundNumber, seq: _testSequencer),
                StepSeq(buttonId: 13, sound: _soundNumber, seq: _testSequencer),
                StepSeq(buttonId: 14, sound: _soundNumber, seq: _testSequencer),
                StepSeq(buttonId: 15, sound: _soundNumber, seq: _testSequencer),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black87)),
                  onPressed: () => Navigator.pop(context),
                  child: Text("Back"),
                ),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black87)),
                    onPressed: () => _resetSequencer(_testSequencer),
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

class StepSeq extends StatefulWidget {
  final int buttonId;
  final int sound;
  final List seq;
  StepSeq({@required this.buttonId, @required this.sound, @required this.seq});
  _StepState createState() => _StepState();
}

class _StepState extends State<StepSeq> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text((widget.buttonId + 1).toString()),
      textColor: Colors.white,
      splashColor: Colors.transparent,
      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black87)),
      color: widget.seq[widget.buttonId] ? Colors.blue : Colors.white10,
      onPressed: () => sequencerPressed(widget.buttonId, widget.seq),
    );
  }

  sequencerPressed(buttonId, seq) {
    if (seq[buttonId]) {
      setState(() {
        seq[buttonId] = false;
      });
    } else if (!seq[buttonId]) {
      setState(() {
        seq[buttonId] = true;
      });
    }
  }
}

// TODO: SetState väritykset
_resetSequencer(seq) {
  for (var i = 0; i < 16; i++) {
    seq[i] = false;
  }
}
