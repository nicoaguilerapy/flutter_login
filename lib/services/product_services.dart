import 'package:flutter/material.dart';
import 'package:flutter_login/models/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductServices extends ChangeNotifier {
  final String _baseUrl = 'flutterlogin-e6e99-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  late Product selectedProduct;
  bool isSaving = false;
  bool isLoading = true;
  ProductServices() {
    loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    this.isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, '/productos.json');
    final res = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode(res.body);
    productsMap.forEach((key, value) {
      final tempProd = Product.fromMap(value);
      tempProd.id = key;
      this.products.add(tempProd);
    });
    this.isLoading = false;
    notifyListeners();
    return this.products;
  }

  Future saveOrCreateProduct(Product product) async {
    this.isSaving = true;
    notifyListeners();
    if (product.id == null) {
      await this.createProduct(product);
    } else {
      await this.updateProduct(product);
    }
    this.isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, '/productos/${product.id}.json');
    final res = await http.put(url, body: product.toJson());
    final decodeResponse = res.body;
    final index =
        this.products.indexWhere((element) => element.id == product.id);
    this.products[index] = product;
    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, '/productos.json');
    final res = await http.post(url, body: product.toJson());
    final decodeDara = json.decode(res.body);
    product.id = decodeDara['name'];
    this.products.add(product);

    return product.id!;
  }
}
