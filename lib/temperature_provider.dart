import 'package:flutter/material.dart';

class TemperatureProvider extends ChangeNotifier {
  double _celsius = 0;
  double _result = 0;
  String _type = "Fahrenheit";

  double get celsius => _celsius;
  double get result => _result;
  String get type => _type;

  void setCelsius(double value) {
    _celsius = value;
    convert();
  }

  void setType(String value) {
    _type = value;
    convert();
  }

  void convert() {
    if (_type == "Fahrenheit") {
      _result = (_celsius * 9 / 5) + 32;
    } else if (_type == "Kelvin") {
      _result = _celsius + 273.15;
    }
    notifyListeners();
  }
}
