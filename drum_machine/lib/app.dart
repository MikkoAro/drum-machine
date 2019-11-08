import 'package:flutter/material.dart';
import 'screens/MainUI.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainUI(
      ),
    );
  }
}