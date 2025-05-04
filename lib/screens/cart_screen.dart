import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/product_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          final cartItems = List<ProductItem>.from(cartProvider.items);

          if (cartItems.isEmpty) {
            return const Center(child: Text('El carrito está vacío'));
          }

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (_, index) {
              final item = cartItems[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Image.network(
                    item.productImage,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) =>
                            const Icon(Icons.broken_image),
                  ),
                  title: Text(item.productName),
                  subtitle: Text('\$${item.productPrice} CLP'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      //  método seguro con índice,
                      Provider.of<CartProvider>(
                        context,
                        listen: false,
                      ).removeItem(item);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder:
            (context, cartProvider, _) => Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Total: \$${cartProvider.totalPrice} CLP',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      ),
    );
  }
}
