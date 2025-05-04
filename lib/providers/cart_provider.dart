import 'package:flutter/material.dart';
import '../models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<ProductItem> _cartItems = [];

  List<ProductItem> get items => _cartItems;

  void addItem(ProductItem product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeItem(ProductItem product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  int get itemCount => _cartItems.length;

  // para calcular el total en CLP
  int get totalPrice {
    return _cartItems.fold(0, (sum, item) => sum + item.productPrice);
  }
}
