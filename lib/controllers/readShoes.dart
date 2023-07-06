import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gsneaker/models/shoe.dart';

class ListShoesProvider extends ChangeNotifier {
  List<Shoe> _shoes = [];

  List<Shoe> get shoes => _shoes;

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data/shoes.json');
    Iterable data = await json.decode(response)['shoes'];

    _shoes = List<Shoe>.from(data.map((model) => Shoe.fromMap(model)));
    notifyListeners();
  }
}