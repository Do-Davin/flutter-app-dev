import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ex2_cart.dart';

class WishlistModel extends ChangeNotifier {
  final List<String> _items = [];

  List<String> get items => _items;

  bool isWishlisted(String name) => _items.contains(name);

  void add(String name) {
    _items.add(name);
    notifyListeners();
  }

  void remove(String name) {
    _items.remove(name);
    notifyListeners();
  }
}

class WishlistShopScreen extends StatelessWidget {
  const WishlistShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    final wishlist = context.watch<WishlistModel>();
    final primary = Theme.of(context).colorScheme.primary;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shop'),
          backgroundColor: primary,
          foregroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Badge(
                label: Text('${wishlist.items.length}'),
                isLabelVisible: wishlist.items.isNotEmpty,
                child: const Icon(Icons.favorite_border),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Badge(
                label: Text('${cart.items.length}'),
                isLabelVisible: cart.items.isNotEmpty,
                child: const Icon(Icons.shopping_cart),
              ),
            ),
          ],
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.store), text: 'Products'),
              Tab(icon: Icon(Icons.shopping_bag), text: 'Cart'),
              Tab(icon: Icon(Icons.favorite), text: 'Wishlist'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [_ProductsTab(), _CartTab(), _WishlistTab()],
        ),
      ),
    );
  }
}

class _ProductsTab extends StatelessWidget {
  const _ProductsTab();

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistModel>();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final wishlisted = wishlist.isWishlisted(product.name);

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.devices,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            title: Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    wishlisted ? Icons.favorite : Icons.favorite_border,
                    color: wishlisted ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    final wl = context.read<WishlistModel>();
                    if (wishlisted) {
                      wl.remove(product.name);
                    } else {
                      wl.add(product.name);
                    }
                  },
                ),
                FilledButton(
                  onPressed: () {
                    context.read<CartModel>().add(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to cart'),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CartTab extends StatelessWidget {
  const _CartTab();

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();

    if (cart.items.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 12),
            Text(
              'Your cart is empty',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final item = cart.items[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.check)),
                  title: Text(item.name),
                  trailing: Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '\$${cart.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WishlistTab extends StatelessWidget {
  const _WishlistTab();

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistModel>();

    if (wishlist.items.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite_border, size: 64, color: Colors.grey),
            SizedBox(height: 12),
            Text(
              'No items in wishlist',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: wishlist.items.length,
      itemBuilder: (context, index) {
        final name = wishlist.items[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.favorite, color: Colors.white),
            ),
            title: Text(name),
            trailing: IconButton(
              icon: const Icon(Icons.close, color: Colors.grey),
              onPressed: () => context.read<WishlistModel>().remove(name),
            ),
          ),
        );
      },
    );
  }
}
