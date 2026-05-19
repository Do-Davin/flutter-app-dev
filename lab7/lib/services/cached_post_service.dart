import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:lab7/models/post.dart';

class CachedPostService {
  final Box<Post> box = Hive.box<Post>('paginated_posts');
  int page = 1;
  bool hasMore = true;

  List<Post> getCached() {
    List<Post> posts = box.values.toList();
    posts.sort((a, b) => a.id.compareTo(b.id));
    return posts;
  }

  Future<void> loadNextPage() async {
    if (!hasMore) {
      return;
    }

    Uri url = Uri.parse(
      'https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=10',
    );
    http.Response response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load posts');
    }

    List data = jsonDecode(response.body);

    if (data.isEmpty) {
      hasMore = false;
      return;
    }

    for (Map<String, dynamic> json in data) {
      Post post = Post.fromJson(json);
      await box.put(post.id, post);
    }

    page++;
  }

  Future<void> clearAndReset() async {
    await box.clear();
    page = 1;
    hasMore = true;
  }
}
