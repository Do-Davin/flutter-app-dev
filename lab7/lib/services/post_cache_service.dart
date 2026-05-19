import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:lab7/models/post.dart';

class PostCacheService {
  Box<Post> get box => Hive.box<Post>('posts');

  List<Post> getCachedPosts() {
    List<Post> posts = box.values.toList();
    posts.sort((a, b) => a.id.compareTo(b.id));
    return posts;
  }

  Future<int> syncPosts() async {
    Uri url = Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=30');
    http.Response response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to sync posts');
    }

    List data = jsonDecode(response.body);

    for (Map<String, dynamic> json in data) {
      Post post = Post.fromJson(json);
      await box.put(post.id, post);
    }

    return data.length;
  }

  Future<void> clearCache() async {
    await box.clear();
  }
}
