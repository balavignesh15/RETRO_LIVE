import 'package:flutter/cupertino.dart';

class CatProvider extends ChangeNotifier {
  List<Map<String, String>> cat = [];
  List<Map<String, String>> pay = [];

  void updateCat(List<Map<String, String>> newCat) {
    cat = newCat;
    notifyListeners();
  }
  void updatePay(List<Map<String, String>> newPay) {
    pay = newPay;
    notifyListeners();
  }

}