import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:lab5/ex2_cart.dart';
import 'package:lab5/ex3_wishlist.dart';

void main() {
  testWidgets('WishlistShopScreen renders', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartModel()),
          ChangeNotifierProvider(create: (_) => WishlistModel()),
        ],
        child: const MaterialApp(home: WishlistShopScreen()),
      ),
    );
    await tester.pump();
    expect(find.text('Shop'), findsOneWidget);
  });
}
