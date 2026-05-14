import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'register_screen.dart';

class InfiniteScreen extends StatefulWidget {
  const InfiniteScreen({super.key});

  @override
  State<InfiniteScreen> createState() {
    return _InfiniteState();
  }
}

class _InfiniteState extends State<InfiniteScreen> {
  final ScrollController _scrollCtrl = ScrollController();
  final List<Map<String, dynamic>> _posts = [];

  int _page = 1;
  bool _loading = false;
  bool _hasMore = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadMore();
    _scrollCtrl.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _onScroll() {
    double currentPosition = _scrollCtrl.position.pixels;
    double bottomPosition = _scrollCtrl.position.maxScrollExtent;

    bool nearBottom = currentPosition >= bottomPosition - 200;

    if (nearBottom && !_loading && _hasMore) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    setState(() {
      _loading = true;
      _errorMessage = '';
    });

    try {
      Uri url = Uri.https('jsonplaceholder.typicode.com', '/posts', {
        '_page': _page.toString(),
        '_limit': '10',
      });

      http.Response response = await http.get(url);

      if (!mounted) {
        return;
      }

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<Map<String, dynamic>> newPosts = data.map((item) {
          return item as Map<String, dynamic>;
        }).toList();

        setState(() {
          _posts.addAll(newPosts);
          _page++;
          _loading = false;

          if (newPosts.isEmpty) {
            _hasMore = false;
          }
        });
      } else {
        setState(() {
          _loading = false;
          _errorMessage =
              'Could not load posts. Status: ${response.statusCode}';
        });
      }
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _loading = false;
        _errorMessage = error.toString();
      });
    }
  }

  Widget _buildPostItem(Map<String, dynamic> post) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          child: Text(post['id'].toString()),
        ),
        title: Text(post['title']),
        subtitle: Text(post['body']),
      ),
    );
  }

  Widget _buildLoadingItem() {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildEndMessage() {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Center(child: Text('No more posts.')),
    );
  }

  Widget _buildErrorMessage() {
    if (_errorMessage.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(_errorMessage, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: _loadMore, child: const Text('Try Again')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int extraItemCount = 0;

    if (_loading) {
      extraItemCount = 1;
    } else if (!_hasMore) {
      extraItemCount = 1;
    } else if (_errorMessage.isNotEmpty) {
      extraItemCount = 1;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Infinite Scroll List')),
      body: SafeArea(
        child: ListView.builder(
          controller: _scrollCtrl,
          padding: const EdgeInsets.all(12),
          itemCount: _posts.length + extraItemCount,
          itemBuilder: (context, index) {
            if (index < _posts.length) {
              return _buildPostItem(_posts[index]);
            }

            if (_loading) {
              return _buildLoadingItem();
            }

            if (!_hasMore) {
              return _buildEndMessage();
            }

            return _buildErrorMessage();
          },
        ),
      ),
    );
  }
}
