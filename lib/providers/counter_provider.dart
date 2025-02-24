import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    if (_counter < 99) {
      _counter++;
      notifyListeners();
    }
  }

  void decrement() {
    if (_counter > 0) {
      _counter--;
      notifyListeners();
    }
  }

  void setCounter(int value) {
    _counter = value;
    notifyListeners();
  }

  void reset() {
    _counter = 0;
    notifyListeners();
  }
}
