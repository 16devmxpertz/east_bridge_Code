import 'package:flutter/foundation.dart';

class GlobalState with ChangeNotifier {
  bool _showFirstWidget = false;

  bool get showFirstWidget => _showFirstWidget;

  void toggleWidget() {
    _showFirstWidget = !_showFirstWidget;
    notifyListeners();
  }
}



