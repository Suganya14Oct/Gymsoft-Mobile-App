import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class MainScreenNotifier extends ChangeNotifier {

  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  set pageIndex(int newIndex){
    _pageIndex = newIndex;
    notifyListeners();
  }
}


class ProfileNotifier extends ChangeNotifier {

  Map<String, dynamic>? apiData;

  void setApiData(Map<String, dynamic> data) {
    apiData = data;
    notifyListeners();
  }

  Map<String, dynamic>? getApiData() {
    return apiData;
  }

}