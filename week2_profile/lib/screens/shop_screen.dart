import 'package:flutter/material.dart';
import 'package:week2_profile/theme/app_theme.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildProductCard(
          name: 'Wireless Speaker',
          subtitle: 'Bluetooth 5.0',
          price: '\$49',
          cents: '.99',
          bgColor: Colors.pinkAccent.shade100,
          imagePath: 'assets/images/speaker.png',
        ),
        const SizedBox(height: 16),
        _buildProductCard(
          name: 'Headphones Pro',
          subtitle: 'Noise Cancelling',
          price: '\$89',
          cents: '.99',
          bgColor: Colors.lightBlueAccent,
          imagePath: 'assets/images/headphones.png',
        ),
        const SizedBox(height: 16),
        _buildProductCard(
          name: 'Laptop Pro',
          subtitle: 'Chip M6 Ultra',
          price: '\$11199',
          cents: '.99',
          bgColor: Colors.greenAccent,
          imagePath: 'assets/images/laptop.png',
        ),
      ],
    );
  }

  Widget _buildProductCard({
    required String name,
    required String subtitle,
    required String price,
    required String cents,
    required Color bgColor,
    required String imagePath,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            subtitle,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.teal,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 11.0),
                          child: Text(
                            cents,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.shopping_cart_outlined),
                    label: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
