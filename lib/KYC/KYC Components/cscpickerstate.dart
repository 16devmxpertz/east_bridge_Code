import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CSCSelectionProvider extends ChangeNotifier {
  String selectedCountry = '';
  String selectedCity = '';
  String selectedState = '';

  void updateValues(String country, String state, String city) {
    selectedCountry = country;
    selectedCity = city;
    selectedState = state;
    notifyListeners();
  }
}
