// import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import './product.dart';
import '../models/http_exception.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  // void toggleFavoritesStatus(){
  //   isFavorite = !isFavorite;
  //   notifyListeners();
  // }

  Future<void> toggleFavoritesStatus(String token, String userId) async {
    final url = 'https://flutter-shop-app-7d1f3.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    // final existingProductIndex =
    //     _items.indexWhere((element) => element.id == id);
    // var existingFavoriteSStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final response = await http.put(url,
          body: json.encode(
            isFavorite
          ));

    if (response.statusCode >= 400) { // only post request throw error other reques just send different status code such as 300 400 etc..
      isFavorite = !isFavorite;
      notifyListeners();
      throw HttpException('Could not change favorite status!');
    }

    // existingProduct = null;
  }

 
}
