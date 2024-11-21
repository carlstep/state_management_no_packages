import 'package:flutter/material.dart';
import 'package:state_management_no_packages/main.dart';
import 'package:state_management_no_packages/services/cart_service.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = CartContainer.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart View'),
      ),
      body: ListenableBuilder(
        listenable: cartService,
        builder: (context, child) {
          if (cartService.products.isEmpty) {
            return const Center(
              child: Text('No Products Selected'),
            );
          } else {
            return ListView.separated(
              itemBuilder: (context, index) {
                final product = cartService.products[index];

                return ListTile(
                  title: Text(product.name),
                  trailing: IconButton(
                    onPressed: () => cartService.removeProduct(product),
                    icon: const Icon(
                      Icons.remove_circle,
                      color: Colors.red,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: cartService.products.length,
            );
          }
        },
      ),
    );
  }
}
