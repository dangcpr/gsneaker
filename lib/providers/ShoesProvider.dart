import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gsneaker/models/shoe.dart';


class ListShoesProvider extends ChangeNotifier {
  List<Shoe> _shoes = [];

  List<Shoe> _listShoesBuy = [];
  double _totalPrice = 0;

  List<Shoe> get shoes => _shoes;
  List<Shoe> get listShoesBuy => _listShoesBuy;
  double get totalPrice => _totalPrice;

  Future<void> readJson() async {
    try {
      final String response = await rootBundle.loadString('assets/data/shoes.json');
      Iterable data = await json.decode(response)['shoes'];

      _shoes = List<Shoe>.from(data.map((model) => Shoe.fromMap(model)));
      notifyListeners();
    } catch (e) {
      debugPrint('Error: readJson: ' + e.toString());
    }
  }

  void updateItemToCart(List<Shoe> list) {
    _shoes = list;
    notifyListeners();
  }

  void addShoesToCart(Shoe shoe) {
    _listShoesBuy.add(shoe);
    notifyListeners();
  }

  void deleteShoesFromCart(Shoe shoe) {
    int index = _listShoesBuy.indexWhere((e) => e.id == shoe.id);
    _listShoesBuy.removeAt(index);
    notifyListeners();
  }

  void deleteShoesToCartAuto() {
    for (int i = 0; i < _listShoesBuy.length; i++) {
      if(_listShoesBuy[i].quantity <= 0)
        _listShoesBuy.removeAt(i);
    }
    notifyListeners();
  }

  void changeQuantityToCartPlus(Shoe shoe) {
    int index = _listShoesBuy.indexWhere((e) => e.id == shoe.id);
    _listShoesBuy[index].quantity = _listShoesBuy[index].quantity + 1;
    notifyListeners();
  }

  void changeQuantityToCartMinus(Shoe shoe) {
    int index = _listShoesBuy.indexWhere((e) => e.id == shoe.id);
    _listShoesBuy[index].quantity = _listShoesBuy[index].quantity - 1;
    notifyListeners();
  }

  void caculatePrice() {
    _totalPrice = 0;
    for (int i = 0; i < _listShoesBuy.length; i++) {
      _totalPrice += _listShoesBuy[i].price * _listShoesBuy[i].quantity;
    }
    notifyListeners();
  }
}