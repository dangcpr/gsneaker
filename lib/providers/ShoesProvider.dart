import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gsneaker/models/shoe.dart';
import 'package:shared_preferences/shared_preferences.dart';


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

  Future<void> updateCartFromLocal() async {
    try {
      //Get data Local Storage
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? response = prefs.getString('listShoesBuy');

      if(response == null) return;

      Iterable data = await json.decode(response);

      _listShoesBuy = List<Shoe>.from(data.map((model) => Shoe.fromMap(model)));
      caculatePrice();
      notifyListeners();
    } catch (e) {
      debugPrint('Error: updateCartFromLocal: ' + e.toString());
    }
  }

  Future<void> addShoesToCart(Shoe shoe) async {
    try {
      _listShoesBuy.add(shoe);

      //Save into Local Storage
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('listShoesBuy', json.encode(_listShoesBuy));
      notifyListeners();
    } catch (e) {
      debugPrint('Error: addShoesToCart: ' + e.toString());
    }
  }

  Future<void> deleteShoesFromCart(Shoe shoe) async {
    try {
      int index = _listShoesBuy.indexWhere((e) => e.id == shoe.id);
      _listShoesBuy.removeAt(index);

      //Save into Local Storage
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('listShoesBuy', json.encode(_listShoesBuy));
      notifyListeners();
    } catch (e) {
      debugPrint('Error: deleteShoesFromCart: ' + e.toString());
    }
  }

  Future<void> deleteShoesToCartAuto() async {
    try {
      for (int i = 0; i < _listShoesBuy.length; i++) {
        if(_listShoesBuy[i].quantity <= 0)
          _listShoesBuy.removeAt(i);
      }

      //Save into Local Storage
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('listShoesBuy', json.encode(_listShoesBuy));
      notifyListeners();
    } catch (e) {
      debugPrint('Error: deleteShoesToCartAuto: ' + e.toString());
    }
  }

  Future<void> changeQuantityToCartPlus(Shoe shoe) async {
    try {
      int index = _listShoesBuy.indexWhere((e) => e.id == shoe.id);
      _listShoesBuy[index].quantity = _listShoesBuy[index].quantity + 1;

      //Save into Local Storage
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('listShoesBuy', json.encode(_listShoesBuy));
      notifyListeners();
    } catch (e) {
      debugPrint('Error: changeQuantityToCartPlus: ' + e.toString());
    }
  }

  Future<void> changeQuantityToCartMinus(Shoe shoe) async {
    try {
      int index = _listShoesBuy.indexWhere((e) => e.id == shoe.id);
      _listShoesBuy[index].quantity = _listShoesBuy[index].quantity - 1;

      //Save into Local Storage
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('listShoesBuy', json.encode(_listShoesBuy));
      notifyListeners();
    } catch (e) {
      debugPrint('Error: changeQuantityToCartMinus: ' + e.toString());
    }
  }

  void caculatePrice() {
    _totalPrice = 0;
    for (int i = 0; i < _listShoesBuy.length; i++) {
      _totalPrice += _listShoesBuy[i].price * _listShoesBuy[i].quantity;
    }
    notifyListeners();
  }
}