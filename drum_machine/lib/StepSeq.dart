import 'package:flutter/material.dart';
import 'screens/Sequencer.dart';


class StepSeq extends StatefulWidget {
  final int buttonId;

  StepSeq({Key key, @required this.buttonId}) : super(key: key);
  _StepState createState() => _StepState();
}

class _StepState extends State<StepSeq> {
  bool isTriggered = false;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(widget.buttonId.toString()),
      textColor: Colors.white,
      splashColor: Colors.transparent,
      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black87)),
      color: isTriggered ? Colors.blue : Colors.white10,
      //onPressed: () => setState(() => isTriggered = !isTriggered),
      onPressed: () => sequencerPressed(widget.buttonId),
    );
  }

  sequencerPressed(buttonId) {
    setState(() {
      if (isTriggered) {
        setState(() {
          isTriggered = !isTriggered;
          makeList(buttonId, isTriggered);
        });
      } else {
        setState(() {
          isTriggered = !isTriggered;
          makeList(buttonId, isTriggered);
        });
      }
    });
  }
}




makeList(buttonId, bool) {
  var listId = buttonId - 1;
  if (sound1 == 1) {
    sound1Seq[listId] = bool;
  }
  if (sound2 == 1) {
    sound2Seq[listId] = bool;
  }
  if (sound3 == 1) {
    sound3Seq[listId] = bool;
  }
  if (sound4 == 1) {
    sound4Seq[listId] = bool;
  }
  if (sound5 == 1) {
    sound5Seq[listId] = bool;
  }
  if (sound6 == 1) {
    sound6Seq[listId] = bool;
  }
  if (sound7 == 1) {
    sound7Seq[listId] = bool;
  }
  if (sound8 == 1) {
    sound8Seq[listId] = bool;
  }
}


passValue(soundNumber) {
  if (soundNumber == 1) {
    sound1 = 1;
  } else {
    sound1 = 0;
  }
  if (soundNumber == 2) {
    sound2 = 1;
  } else {
    sound2 = 0;
  }
  if (soundNumber == 3) {
    sound3 = 1;
  } else {
    sound3 = 0;
  }
  if (soundNumber == 4) {
    sound4 = 1;
  } else {
    sound4 = 0;
  }
  if (soundNumber == 5) {
    sound5 = 1;
  } else {
    sound5 = 0;
  }
  if (soundNumber == 6) {
    sound6 = 1;
  } else {
    sound6 = 0;
  }
  if (soundNumber == 7) {
    sound7 = 1;
  } else {
    sound7 = 0;
  }
  if (soundNumber == 8) {
    sound8 = 1;
  } else {
    sound8 = 0;
  }
}
