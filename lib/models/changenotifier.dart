import 'package:flutter/cupertino.dart';

class CountingNumber extends ChangeNotifier {
  int number = 0;
  String message = 'Selva T';

  void increaseNumber(int number) {
    number++;
    notifyListeners();
  }

  void testMessage() {
    message.startsWith('S')
        ? message = 'Hi Selva !!'
        : message = 'not start with S';
    notifyListeners();
  }
}
