import 'package:flutter/material.dart';
import 'package:lab7/models/post.dart';
import 'package:lab7/services/post_cache_service.dart';

class PostCacheScreen extends StatefulWidget {
  const PostCacheScreen({super.key});

  @override
  State<PostCacheScreen> createState() => _PostCacheScreenState();
}

class _PostCacheScreenState extends State<PostCacheScreen> {
  final PostCacheService postService = PostCacheService();
  List<Post> posts = [];
  bool syncing = false;
  String status = 'Cached posts';

  @override
  void initState() {
    super.initState();
    posts = postService.getCachedPosts();
    syncPosts();
  }

  Future<void> syncPosts() async {
    setState(() {
      syncing = true;
      status = 'Syncing...';
    });

    try {
      int count = await postService.syncPosts();

      setState(() {
        posts = postService.getCachedPosts();
        syncing = false;
        status = 'Synced $count posts';
      });
    } catch (error) {
      setState(() {
        syncing = false;
        status = 'Sync failed';
      });
    }
  }

  Future<void> clearCache() async {
    await postService.clearCache();
    setState(() {
      posts = [];
      status = 'Cache cleared';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts Cache'),
        actions: [
          IconButton(onPressed: clearCache, icon: const Icon(Icons.delete)),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: syncing ? Colors.orange.shade100 : Colors.green.shade100,
            child: Text(status),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: syncPosts,
              child: posts.isEmpty
                  ? ListView(
                      children: const [
                        SizedBox(height: 240),
                        Center(child: Text('No cached posts')),
                      ],
                    )
                  : ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        Post post = posts[index];

                        return ListTile(
                          title: Text(post.title),
                          subtitle: Text(post.body),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
