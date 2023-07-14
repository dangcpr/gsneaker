import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gsneaker/constants/serverURL.dart';
import 'package:gsneaker/models/shoe.dart';
import 'package:dio/dio.dart';

class ShoesController {
  Future<List<Shoe>> readAllProduct(BuildContext context) async {
    try {
      String urlAPI = '$uri/products';
      Response response = await dio.get(
        urlAPI,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          }
        )
      );
      //Iterable data = await json.decode(response.data)['shoes'];
      //List<dynamic> shoesTemp = response.data['shoes'];
      
      if (response.statusCode == 200) {
        List<Shoe> _shoes = (response.data['shoes'] as List).map((shoe) => Shoe.fromMap(shoe)).toList();
        return _shoes;
      } else {
        //Controller -> View
        SnackBar snackBar = SnackBar(
          content: Text('Error when getting data: ${json.decode(response.data)['message']}'),
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