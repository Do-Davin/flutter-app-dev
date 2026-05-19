import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class CartItem extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late double price;

  @HiveField(2)
  late int quantity;
}

class CartItemAdapter extends TypeAdapter<CartItem> {
  @override
  final int typeId = 1;

  @override
  CartItem read(BinaryReader reader) {
    CartItem item = CartItem();
    item.name = reader.readString();
    item.price = reader.readDouble();
    item.quantity = reader.readInt();
    return item;
  }

  @override
  void write(BinaryWriter writer, CartItem obj) {
    writer.writeString(obj.name);
    writer.writeDouble(obj.price);
    writer.writeInt(obj.quantity);
  }
}
