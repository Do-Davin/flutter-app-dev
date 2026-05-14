import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../services/todo_service.dart';
import 'register_screen.dart';

class CrudScreen extends StatefulWidget {
  const CrudScreen({super.key});

  @override
  State<CrudScreen> createState() {
    return _CrudScreenState();
  }
}

class _CrudScreenState extends State<CrudScreen> {
  final TodoService _todoService = TodoService();
  final TextEditingController _todoCtrl = TextEditingController();

  late Future<List<Todo>> _todosFuture;
  List<Todo> _todos = [];
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _todosFuture = _loadTodos();
  }

  @override
  void dispose() {
    _todoCtrl.dispose();
    super.dispose();
  }

  Future<List<Todo>> _loadTodos() async {
    _todos = await _todoService.getAll();
    return _todos;
  }

  void _refreshTodos() {
    setState(() {
      _todosFuture = _loadTodos();
    });
  }

  Future<void> _addTodo() async {
    String title = _todoCtrl.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a todo title.')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      Todo newTodo = await _todoService.create(title);

      setState(() {
        _todos.insert(0, newTodo);
        _todosFuture = Future.value(_todos);
        _todoCtrl.clear();
      });
    } catch (error) {
      _showError('Could not create todo.');
    }

    setState(() {
      _isSaving = false;
    });
  }

  Future<bool> _deleteTodo(Todo todo) async {
    try {
      await _todoService.delete(todo.id);

      setState(() {
        _todos.removeWhere((item) {
          return item.id == todo.id;
        });
        _todosFuture = Future.value(_todos);
      });
      return true;
    } catch (error) {
      _showError('Could not delete todo.');
      return false;
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildTodoList(List<Todo> todos) {
    if (todos.isEmpty) {
      return const Center(child: Text('No todos found.'));
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        Todo todo = todos[index];

        return Dismissible(
          key: ValueKey(todo.id),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            color: Colors.red,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          confirmDismiss: (direction) async {
            return _deleteTodo(todo);
          },
          child: Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                child: Text(todo.id.toString()),
              ),
              title: Text(todo.title),
              subtitle: Text(todo.completed ? 'Completed' : 'Not completed'),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Todos'),
        actions: [
          IconButton(onPressed: _refreshTodos, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _todoCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Todo title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _isSaving ? null : _addTodo,
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Todo>>(
                future: _todosFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Could not load todos.',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              snapshot.error.toString(),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: _refreshTodos,
                              child: const Text('Try Again'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  List<Todo> todos = snapshot.data ?? [];
                  return _buildTodoList(todos);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
