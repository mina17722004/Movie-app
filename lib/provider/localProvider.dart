import 'package:flutter/cupertino.dart';

class LocalProvider extends ChangeNotifier {
  String _locale = "ar";

  String get locale => _locale;

  set locale(String locale) {
    _locale = locale;
    notifyListeners();
  }
}