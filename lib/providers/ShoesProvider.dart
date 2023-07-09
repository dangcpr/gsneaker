import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gsneaker/constants/shoes.dart';
import 'package:gsneaker/controllers/readShoes.dart';
import 'package:gsneaker/models/shoe.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ListShoesProvider extends ChangeNotifier {
  List<Shoe> _shoes = [];

  List<Shoe> _listShoesBuy = [];
  double _totalPrice = 0;

  List<Shoe> get shoes => _shoes;
  List<Shoe> get listShoesBuy => _listShoesBuy;
  double get totalPrice => _totalPrice;

  Future<void> readJson(BuildContext context) async {
    try {
      //final String response = await rootBundle.loadString('assets/data/shoes.json');
      //Iterable data = await json.decode(response)['shoes'];
      _shoes = await ShoesController().readAllProduct(context);
      notifyListeners();
    } catch (e) {
      debugPrint('Error: readJson: ' + e.toString());
    }
  }

  Future<void> updateCartFromLocal() async {
    try {
      //Only for testing
      /*
      SharedPreferences.setMockInitialValues({
        'listShoesBuy': "[{\"id\":1,\"image\":\"https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/air-zoom-pegasus-36-mens-running-shoe-wide-D24Mcz-removebg-preview.png\",\"name\":\"NikeAirZoomPegasus36\",\"description\":\"TheiconicNikeAirZoomPegasus36offersmorecoolingandmeshthattargetsbreathabilityacrosshigh-heatareas.Aslimmerheelcollarandtonguereducebulk,whileexposedcablesgiveyouasnugfitathigherspeeds.\",\"price\":108.97,\"color\":\"#e1e7ed\",\"quantity\":2},{\"id\":2,\"image\":\"https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/air-zoom-pegasus-36-shield-mens-running-shoe-24FBGb__1_-removebg-preview.png\",\"name\":\"NikeAirZoomPegasus36Shield\",\"description\":\"TheNikeAirZoomPegasus36Shieldgetsupdatedtoconquerwetroutes.Awater-repellentuppercombineswithanoutsolethathelpscreategriponwetsurfaces,lettingyouruninconfidencedespitetheweather.\",\"price\":89.97,\"color\":\"#4D317F\",\"quantity\":3}]"
      });
*/
      //Get data Local Storage
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? response = prefs.getString('listShoesBuy');
      //prefs.remove('listShoesBuy');
      if(response == null) return;

      List<dynamic> data = await json.decode(response);

      //_listShoesBuy = List<Shoe>.from(data2.map((model) => Shoe.fromMap(model)));
      _listShoesBuy = data.map((shoeJson) => Shoe.fromJson(shoeJson)).toList();
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
      int index = _listShoesBuy.indexWhere((e) => e.productID == shoe.productID);
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
      int index = _listShoesBuy.indexWhere((e) => e.productID == shoe.productID);
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
      int index = _listShoesBuy.indexWhere((e) => e.productID == shoe.productID);
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