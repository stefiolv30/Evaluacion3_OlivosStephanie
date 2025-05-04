import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _productService = ProductService();

  List<ProductItem> _products = [];
  List<ProductItem> _filteredProducts = [];

  List<ProductItem> get products => _filteredProducts;

  ProductProvider() {
    cargarProductos();
  }

  Future<void> cargarProductos() async {
    try {
      _products = await _productService.cargarProductos();
      _filteredProducts = _products;
      notifyListeners();
    } catch (e) {
      print('Error cargando productos: $e');
    }
  }

  // Buscador por nombre
  void buscarProducto(String query) {
    _filteredProducts =
        _products
            .where(
              (product) => product.productName.toLowerCase().contains(
                query.toLowerCase(),
              ),
            )
            .toList();
    notifyListeners();
  }

  // Ordenar por nombre A-Z
  void ordenarPorNombreAZ() {
    _filteredProducts.sort((a, b) => a.productName.compareTo(b.productName));
    notifyListeners();
  }

  // Ordenar por precio de menor a mayor
  void ordenarPorPrecioAscendente() {
    _filteredProducts.sort((a, b) => a.productPrice.compareTo(b.productPrice));
    notifyListeners();
  }
}
