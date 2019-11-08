import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';

//Start
void main(){
  setLandscapeOrientation();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(App());
}

//force into landScapeOrientation
setLandscapeOrientation() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);
}