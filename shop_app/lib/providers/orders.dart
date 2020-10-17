import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  // void addOrder(List<CartItem> cartProducts, double total) {
  //   _orders.insert(
  //     0,
  //     OrderItem(
  //         id: DateTime.now().toString(),
  //         amount: total,
  //         dateTime: DateTime.now(),
  //         products: cartProducts),
  //   ); //add at the begining of the index list
  //   notifyListeners();
  // }

  dynamic dateTimeEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url = 'https://flutter-shop-app-7d1f3.firebaseio.com/orders.json';
    final timestamp = DateTime.now();
    try {
      final response = await http.post(url,
          body: json.encode({
            'amount': total,
            'dateTime': timestamp.toIso8601String(),
            'products': cartProducts.map((e) => {
                  'id': e.id,
                  'title': e.title,
                  'quantity': e.quantity,
                  'price': e.price,
                }).toList(),
          }));
      _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            dateTime: timestamp,
            products: cartProducts),
      ); //add at the begining of the index list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
