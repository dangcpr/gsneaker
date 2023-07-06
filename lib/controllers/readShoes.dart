import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gsneaker/constants/shoes.dart';
import 'package:gsneaker/models/shoe.dart';

class readShoes {
  Future<void> readJson() async {
    try {
      final String response = await rootBundle.loadString('assets/data/shoes.json');
      Iterable data = await json.decode(response)['shoes'];

      listShoes = List<Shoe>.from(data.map((model) => Shoe.fromMap(model)));

    } catch (e) {
      debugPrint('Error: readJson: ' + e.toString());
    }
  }
}