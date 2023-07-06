import 'package:flutter/material.dart';
import 'package:gsneaker/models/shoe.dart';

class ListShoesBuyProvider extends ChangeNotifier {
  List<Shoe> _listShoesBuy = [];

  List<Shoe> get listShoesBut => _listShoesBuy;

  void addShoes(Shoe shoe) {
    _listShoesBuy.add(shoe);
    notifyListeners();
  }

  void deleteShoesAuto() {
    for (int i = 0; i < _listShoesBuy.length; i++) {
      if(_listShoesBuy[i].quantity == 0)
        _listShoesBuy.removeAt(i);
    }
    notifyListeners();
  }

  void changeQuantity(int index, int quantity) {
    _listShoesBuy[index].quantity = quantity;
    notifyListeners();
  }
}