import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductService {
  final String _baseUrl = "143.198.118.203:8100";
  final String _user = "test";
  final String _pass = "test2023";

  List<ProductItem> products = [];

  ProductService() {
    loadProducts();
  }

  // trae el listado del producto
  Future<void> loadProducts() async {
    try {
      products = await cargarProductos();
    } catch (e) {
      print('Error al cargar productos: $e');
    }
  }

  //  MÉTODO PARA OBTENER PRODUCTOS DESDE EL BACKEND
  Future<List<ProductItem>> cargarProductos() async {
    final uri = Uri.http(_baseUrl, '/ejemplos/product_list_rest/');
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';

    final response = await http.get(
      uri,
      headers: {'Authorization': basicAuth, 'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = json.decode(response.body);
      final List<dynamic> listado = decoded['Listado'];
      return listado.map((json) => ProductItem.fromMap(json)).toList();
    } else {
      throw Exception(
        'Error al cargar productos: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
