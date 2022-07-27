import 'package:flutter/material.dart';

class Pressure extends ChangeNotifier {
  bool pressure = true;

  void choice() {
    notifyListeners();
  }
}
