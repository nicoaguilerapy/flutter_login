import 'package:flutter/material.dart';
import 'package:flutter_login/models/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductServices extends ChangeNotifier {
  final String _baseUrl =
      'https://flutterlogin-e6e99-default-rtdb.firebaseio.com';
  final List<Product> products = [];

  bool isLoading = true;
  ProductServices() {
    loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    this.isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'products.json');
    final res = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode(res.body);
    productsMap.forEach((key, value) {
      final tempProd = Product.fromMap(value);
      this.products.add(tempProd);
    });
    this.isLoading = false;
    return this.products;
  }
}
