import 'package:flutter/material.dart';

enum UiState { loading, empty, error, data }

// Mock product model
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.emoji,
  });
  final int id;
  final String name;
  final double price;
  final String emoji;
}

// Mock fetch — simulates real async API call
Future<List<Product>> _fetchProducts({bool simulateError = false}) async {
  await Future.delayed(const Duration(seconds: 2));
  if (simulateError) throw Exception('Network error');
  return const [
    Product(id: 1, name: 'Mechanical Keyboard', price: 129.99, emoji: '⌨️'),
    Product(id: 2, name: 'Wireless Mouse', price: 49.99, emoji: '🖱️'),
    Product(id: 3, name: 'USB-C Hub', price: 39.99, emoji: '🔌'),
    Product(id: 4, name: '4K Webcam', price: 89.99, emoji: '📷'),
    Product(id: 5, name: 'Desk Lamp', price: 34.99, emoji: '💡'),
    Product(id: 6, name: 'Monitor Stand', price: 59.99, emoji: '🖥️'),
  ];
}

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  UiState _uiState = UiState.loading;
  List<Product> _products = [];
  bool _simulateError = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() => _uiState = UiState.loading);
    try {
      final products = await _fetchProducts(simulateError: _simulateError);
      setState(() {
        _products = products;
        _uiState = products.isEmpty ? UiState.empty : UiState.data;
      });
    } catch (_) {
      setState(() => _uiState = UiState.error);
    }
  }

  Widget _buildBody() {
    switch (_uiState) {
      case UiState.loading:
        return const Center(child: CircularProgressIndicator());

      case UiState.empty:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🛒', style: TextStyle(fontSize: 64)),
              const SizedBox(height: 16),
              Text(
                'No products found',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              FilledButton.tonal(
                onPressed: _loadProducts,
                child: const Text('Refresh'),
              ),
            ],
          ),
        );

      case UiState.error:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('⚠️', style: TextStyle(fontSize: 64)),
              const SizedBox(height: 16),
              Text(
                'Something went wrong',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Could not load products. Please try again.',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () {
                  _simulateError = false; // retry clears the error flag
                  _loadProducts();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        );

      case UiState.data:
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemCount: _products.length,
          itemBuilder: (context, index) =>
              _ProductCard(product: _products[index]),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
        actions: [
          // Dev toggle: simulate error on next fetch
          IconButton(
            tooltip: 'Simulate error',
            icon: Icon(
              _simulateError ? Icons.bug_report : Icons.bug_report_outlined,
              color: _simulateError ? Colors.red : null,
            ),
            onPressed: () {
              setState(() => _simulateError = !_simulateError);
              _loadProducts();
            },
          ),
          // Simulate empty state
          IconButton(
            tooltip: 'Simulate empty',
            icon: const Icon(Icons.inbox_outlined),
            onPressed: () {
              setState(() {
                _products = [];
                _uiState = UiState.empty;
              });
            },
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: KeyedSubtree(
          key: ValueKey(_uiState), // triggers animation on state change
          child: _buildBody(),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Emoji thumbnail
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      product.emoji,
                      style: const TextStyle(fontSize: 48),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.name,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
