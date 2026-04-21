import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartModelWithUndo extends ChangeNotifier {
  final List<String> _items = [];

  String? _lastAdded;

  List<String> get items => _items;

  bool get canUndo => _lastAdded != null;

  void add(String item) {
    _items.add(item);
    _lastAdded = item;
    notifyListeners();
  }

  void undo() {
    if (_lastAdded != null) {
      _items.remove(_lastAdded);
      _lastAdded = null;
      notifyListeners();
    }
  }
}

const List<String> _products = ['Headphones', 'Keyboard', 'Mouse', 'Monitor'];

class UndoCartScreen extends StatelessWidget {
  const UndoCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartModelWithUndo(),
      child: const _UndoCartView(),
    );
  }
}

class _UndoCartView extends StatelessWidget {
  const _UndoCartView();

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModelWithUndo>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart with Undo'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.undo),
            tooltip: 'Undo last add',
            onPressed: cart.canUndo
                ? () => context.read<CartModelWithUndo>().undo()
                : null,
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'PRODUCTS',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 2,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _products.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final name = _products[index];
              return ListTile(
                title: Text(name),
                trailing: FilledButton(
                  onPressed: () => context.read<CartModelWithUndo>().add(name),
                  child: const Text('Add'),
                ),
              );
            },
          ),

          const Divider(),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'CART',
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 2,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '${cart.items.length} item${cart.items.length == 1 ? '' : 's'}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          Expanded(
            child: cart.items.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 56,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Empty — add something!',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      final isLast = index == cart.items.length - 1;
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: isLast
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.primaryContainer,
                          child: Icon(
                            Icons.check,
                            color: isLast
                                ? Colors.white
                                : Theme.of(context).colorScheme.primary,
                            size: 18,
                          ),
                        ),
                        title: Text(item),
                        subtitle: isLast
                            ? const Text(
                                'last added — tap ↩ to undo',
                                style: TextStyle(fontSize: 11),
                              )
                            : null,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
