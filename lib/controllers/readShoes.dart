import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gsneaker/constants/shoes.dart';
import 'package:gsneaker/models/shoe.dart';
import 'package:http/http.dart' as http;

class ShoesController {
  Future<List<Shoe>> readAllProduct(BuildContext context) async {
    try {
      final response = await http.get(Uri.parse('$uri/products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );
      Iterable data = await json.decode(response.body)['shoes'];

      List<Shoe> _shoes = List<Shoe>.from(data.map((model) => Shoe.fromMap(model)));
      if (response.statusCode == 200) {
        return _shoes;
      } else {
        //Controller -> View
        SnackBar snackBar = SnackBar(
          content: Text('Error when getting data: ${json.decode(response.body)['message']}'),
          behavior: SnackBarBehavior.floating,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return [];
      }
    } catch (e) {
      //Controller -> View
      SnackBar snackBar = SnackBar(
        content: Text('Internal Error' + e.toString()),
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return [];
    }
  }
}