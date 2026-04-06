import 'package:flutter/material.dart';
import 'package:lab4/screens/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Future<void> _openCheckout(BuildContext context) async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const CheckoutScreen()),
    );

    // Guard: widget may be unmounted while awaiting
    if (!context.mounted) return;

    if (result == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🎉 Order placed successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    } else if (result == 'cancelled') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Checkout cancelled.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
    // result == null means user pressed back — no snackbar needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _CartItem(name: 'Flutter in Action', price: 39.99),
          _CartItem(name: 'Clean Architecture', price: 29.99),
          _CartItem(name: 'NestJS Fundamentals', price: 19.99),
          Divider(height: 32),
          _OrderSummary(total: 89.97),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: FilledButton.icon(
          onPressed: () => _openCheckout(context),
          icon: const Icon(Icons.shopping_bag_outlined),
          label: const Text('Proceed to Checkout'),
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
        ),
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({required this.name, required this.price});

  final String name;
  final double price;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.book_outlined),
      title: Text(name),
      trailing: Text(
        '\$${price.toStringAsFixed(2)}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _OrderSummary extends StatelessWidget {
  const _OrderSummary({required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Total', style: Theme.of(context).textTheme.titleMedium),
        Text(
          '\$${total.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
