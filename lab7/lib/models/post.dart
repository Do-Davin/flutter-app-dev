import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class Post extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String body;

  static Post fromJson(Map<String, dynamic> json) {
    Post post = Post();
    post.id = json['id'];
    post.title = json['title'];
    post.body = json['body'];
    return post;
  }
}

class PostAdapter extends TypeAdapter<Post> {
  @override
  final int typeId = 2;

  @override
  Post read(BinaryReader reader) {
    Post post = Post();
    post.id = reader.readInt();
    post.title = reader.readString();
    post.body = reader.readString();
    return post;
  }

  @override
  void write(BinaryWriter writer, Post obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.body);
  }
}
