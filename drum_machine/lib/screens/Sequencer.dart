import 'package:flutter/material.dart';

class Sequencer extends StatelessWidget {
  final List _sequencer;
  Sequencer(this._sequencer);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height / 0.62;
    final double itemWidth = size.width;
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/backgrd.JPG"),
              fit: BoxFit.cover),
        ),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            GridView.count(
              shrinkWrap: true,
              primary: true,
              padding: const EdgeInsets.fromLTRB(40, 30, 40, 15),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: itemWidth / itemHeight,
              crossAxisCount: 8,
              children: <Widget>[
                StepSeq(buttonId: 0, seq: _sequencer),
                StepSeq(buttonId: 1, seq: _sequencer),
                StepSeq(buttonId: 2, seq: _sequencer),
                StepSeq(buttonId: 3, seq: _sequencer),
                StepSeq(buttonId: 4, seq: _sequencer),
                StepSeq(buttonId: 5, seq: _sequencer),
                StepSeq(buttonId: 6, seq: _sequencer),
                StepSeq(buttonId: 7, seq: _sequencer),
                StepSeq(buttonId: 8, seq: _sequencer),
                StepSeq(buttonId: 9, seq: _sequencer),
                StepSeq(buttonId: 10, seq: _sequencer),
                StepSeq(buttonId: 11, seq: _sequencer),
                StepSeq(buttonId: 12, seq: _sequencer),
                StepSeq(buttonId: 13, seq: _sequencer),
                StepSeq(buttonId: 14, seq: _sequencer),
                StepSeq(buttonId: 15, seq: _sequencer),
                StepSeq(buttonId: 16, seq: _sequencer),
                StepSeq(buttonId: 17, seq: _sequencer),
                StepSeq(buttonId: 18, seq: _sequencer),
                StepSeq(buttonId: 19, seq: _sequencer),
                StepSeq(buttonId: 20, seq: _sequencer),
                StepSeq(buttonId: 21, seq: _sequencer),
                StepSeq(buttonId: 22, seq: _sequencer),
                StepSeq(buttonId: 23, seq: _sequencer),
                StepSeq(buttonId: 24, seq: _sequencer),
                StepSeq(buttonId: 25, seq: _sequencer),
                StepSeq(buttonId: 26, seq: _sequencer),
                StepSeq(buttonId: 27, seq: _sequencer),
                StepSeq(buttonId: 28, seq: _sequencer),
                StepSeq(buttonId: 29, seq: _sequencer),
                StepSeq(buttonId: 30, seq: _sequencer),
                StepSeq(buttonId: 31, seq: _sequencer),
              ],
            ),
            Center(
              child: ButtonTheme(
                minWidth: 40,
                buttonColor: Colors.white70,
                disabledColor: Colors.white70,
                child: BackButton(),
              ),
            ),
          ],
        ));
  }
}

class StepSeq extends StatefulWidget {
  final int buttonId;
  final List seq;
  StepSeq({@required this.buttonId, @required this.seq});
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
      color: widget.seq[widget.buttonId] ? Colors.blue : Colors.white12,
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

class BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black87)),
      onPressed: () => Navigator.pop(context),
      child: Text("Back"),
    );
  }
}
