import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/todo.dart';

class TodoService {
  static const _base = 'https://jsonplaceholder.typicode.com';
  static const Map<String, String> _headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'User-Agent': 'Mozilla/5.0 Flutter Todo App',
  };

  Future<List<Todo>> getAll() async {
    Uri url = Uri.parse('$_base/todos?_limit=20');
    http.Response response = await http
        .get(url, headers: _headers)
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);

      return jsonList.map((json) {
        return Todo.fromJson(json);
      }).toList();
    } else {
      throw Exception('Failed to load todos. Status: ${response.statusCode}');
    }
  }

  Future<Todo> create(String title) async {
    Uri url = Uri.parse('$_base/todos');
    http.Response response = await http
        .post(
          url,
          headers: _headers,
          body: jsonEncode({'title': title, 'completed': false, 'userId': 1}),
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 201) {
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create todo. Status: ${response.statusCode}');
    }
  }

  Future<void> delete(int id) async {
    Uri url = Uri.parse('$_base/todos/$id');
    http.Response response = await http
        .delete(url, headers: _headers)
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo. Status: ${response.statusCode}');
    }
  }
}
