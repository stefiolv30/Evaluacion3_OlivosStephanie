import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';
import '../models/product_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final productos = productProvider.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Productos'),
        backgroundColor: Colors.pinkAccent,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, 'cart');
                },
              ),
              if (cartProvider.itemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cartProvider.itemCount}',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar producto...', //Buscar producto
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => productProvider.buscarProducto(value),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton<String>(
              isExpanded: true,
              value: null,
              hint: const Text('Filtrar por categoría'), //filtro por categorias
              items: const [
                DropdownMenuItem(value: 'nombre', child: Text('Nombre (A-Z)')),
                DropdownMenuItem(
                  value: 'precio',
                  child: Text('Precio ascendente'),
                ),
              ],
              onChanged: (value) {
                if (value == 'nombre') {
                  productProvider.ordenarPorNombreAZ();
                } else if (value == 'precio') {
                  productProvider.ordenarPorPrecioAscendente();
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child:
                productos.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: productos.length,
                      itemBuilder: (context, index) {
                        final producto = productos[index];
                        return _ProductoCard(producto: producto);
                      },
                    ),
          ),
        ],
      ),
    );
  }
}

class _ProductoCard extends StatelessWidget {
  final ProductItem producto;

  const _ProductoCard({required this.producto});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            producto.productImage,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
          ),
        ),
        title: Text(
          producto.productName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('\$${producto.productPrice} CLP'),
        trailing: IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          onPressed: () {
            cartProvider.addItem(producto);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${producto.productName} agregado al carrito'),
              ),
            );
          },
        ),
        onTap: () {
          Navigator.pushNamed(context, 'detalle', arguments: producto);
        },
      ),
    );
  }
}
