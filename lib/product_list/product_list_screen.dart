import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:state_management_no_packages/main.dart';
import 'package:state_management_no_packages/product_list/cart_button.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = ProductContainer.of(context);
    final cartService = CartContainer.of(context);

    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Product List'),
          actions: [
            CartButton(),
          ],
        ),
        body: ListenableBuilder(
          listenable: cartService,
          builder: (context, child) => ListView.separated(
            itemBuilder: (context, index) {
              final product = productService.products[index];
              final isAlreadyInCart = cartService.products.contains(product);

              return ListTile(
                leading: Icon(
                  Icons.shopping_bag,
                  color: isAlreadyInCart ? Colors.green : Colors.transparent,
                ),
                title: Text(product.name),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                trailing: Text(
                  formatter.format(product.price),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.black54),
                ),
                onTap: isAlreadyInCart
                    ? null
                    : () => cartService.addProduct(product),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: productService.products.length,
          ),
        ));
  }
}
