import 'package:hive/hive.dart';
import 'package:lab7/models/cart_item.dart';

class CartService {
  Box<CartItem> get box => Hive.box<CartItem>('cart');

  Future<void> addItem(String name, double price) async {
    CartItem item = CartItem();
    item.name = name;
    item.price = price;
    item.quantity = 1;
    await box.add(item);
  }

  Future<void> removeItem(CartItem item) async {
    await item.delete();
  }

  Future<void> incrementQty(CartItem item) async {
    item.quantity++;
    await item.save();
  }

  double totalPrice() {
    return box.values.fold(0, (sum, item) => sum + item.price * item.quantity);
  }

  Future<void> clearCart() async {
    await box.clear();
  }
}
