import 'dart:convert';

class Product {
  Product({required this.listado});

  List<ProductItem> listado;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    listado: List<ProductItem>.from(
      json["Listado"].map((x) => ProductItem.fromMap(x)),
    ),
  );
}

class ProductItem {
  final int productId;
  final String productName;
  final int productPrice;
  final String productImage;
  final String productState;

  ProductItem({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productState,
  });

  factory ProductItem.fromMap(Map<String, dynamic> json) => ProductItem(
    productId: json["product_id"],
    productName: json["product_name"],
    productPrice: json["product_price"],
    productImage: json["product_image"],
    productState: json["product_state"],
  );
}
