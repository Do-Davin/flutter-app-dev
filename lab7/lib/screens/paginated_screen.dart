import 'package:flutter/material.dart';
import 'package:lab7/models/post.dart';
import 'package:lab7/services/cached_post_service.dart';

class PaginatedScreen extends StatefulWidget {
  const PaginatedScreen({super.key});

  @override
  State<PaginatedScreen> createState() => _PaginatedScreenState();
}

class _PaginatedScreenState extends State<PaginatedScreen> {
  final CachedPostService postService = CachedPostService();
  final ScrollController scrollController = ScrollController();
  List<Post> posts = [];
  bool loading = false;
  String error = '';

  @override
  void initState() {
    super.initState();
    posts = postService.getCached();

    if (posts.isEmpty) {
      loadNextPage();
    }

    scrollController.addListener(checkScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void checkScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadNextPage();
    }
  }

  Future<void> loadNextPage() async {
    if (loading || !postService.hasMore) {
      return;
    }

    setState(() {
      loading = true;
      error = '';
    });

    try {
      await postService.loadNextPage();

      setState(() {
        posts = postService.getCached();
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
        error = 'Could not load posts';
      });
    }
  }

  Future<void> clearAndReload() async {
    await postService.clearAndReset();

    setState(() {
      posts = [];
      error = '';
    });

    await loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite Posts'),
        actions: [
          IconButton(
            onPressed: clearAndReload,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          if (error.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.red.shade100,
              child: Text(error),
            ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: posts.length + 1,
              itemBuilder: (context, index) {
                if (index == posts.length) {
                  if (loading) {
                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (!postService.hasMore) {
                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(child: Text('No more posts')),
                    );
                  }

                  return const SizedBox(height: 80);
                }

                Post post = posts[index];

                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
