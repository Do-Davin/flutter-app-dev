import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'register_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() {
    return _SearchState();
  }
}

class _SearchState extends State<SearchScreen> {
  final _ctrl = TextEditingController();
  Timer? _debounce;
  List<dynamic> _results = [];
  bool _isLoading = false;
  String _message = 'Search posts by typing above.';
  int _searchId = 0;

  @override
  void dispose() {
    _ctrl.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearch(String query) {
    _debounce?.cancel();
    final int searchId = ++_searchId;

    _debounce = Timer(const Duration(milliseconds: 400), () {
      _fetch(query, searchId);
    });
  }

  Future<void> _fetch(String query, int searchId) async {
    String text = query.trim();

    if (text.isEmpty) {
      if (!mounted || searchId != _searchId) {
        return;
      }

      setState(() {
        _results = [];
        _isLoading = false;
        _message = 'Search posts by typing above.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _message = '';
    });

    try {
      Uri url = Uri.https('jsonplaceholder.typicode.com', '/posts', {
        'q': text,
      });

      http.Response response = await http
          .get(
            url,
            headers: const {
              'Accept': 'application/json',
              'User-Agent': 'Mozilla/5.0 Flutter Search App',
            },
          )
          .timeout(const Duration(seconds: 10));

      if (!mounted || searchId != _searchId) {
        return;
      }

      if (response.statusCode == 200) {
        setState(() {
          _results = jsonDecode(response.body);
          _isLoading = false;

          if (_results.isEmpty) {
            _message = 'No posts found.';
          }
        });
      } else {
        setState(() {
          _results = [];
          _isLoading = false;
          _message = 'Could not search posts. Status: ${response.statusCode}';
        });
      }
    } catch (error) {
      if (!mounted || searchId != _searchId) {
        return;
      }

      setState(() {
        _results = [];
        _isLoading = false;
        _message = error.toString();
      });
    }
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_results.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            _message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _results.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> post = _results[index];

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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _ctrl,
          onChanged: _onSearch,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Search posts...',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
        ),
      ),
      body: SafeArea(child: _buildBody()),
    );
  }
}
