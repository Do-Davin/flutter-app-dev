import 'package:flutter/material.dart';
import 'package:lab7/db/note_database.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  void reload() {
    setState(() {});
  }

  Future<void> openNoteForm({Map<String, dynamic>? note}) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return NoteForm(note: note, onSaved: reload);
      },
    );
  }

  Future<void> showNoteOptions(Map<String, dynamic> note) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(note['title']),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                openNoteForm(note: note);
              },
              child: const Text('Edit'),
            ),
            TextButton(
              onPressed: () async {
                await NoteDatabase.deleteNote(note['id']);

                if (context.mounted) {
                  Navigator.pop(context);
                }

                reload();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: NoteDatabase.getAllNotes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text('Database error: ${snapshot.error}'),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          List<Map<String, dynamic>> notes = snapshot.data ?? [];

          if (notes.isEmpty) {
            return const Center(child: Text('No notes yet'));
          }

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> note = notes[index];

              return ListTile(
                title: Text(note['title']),
                subtitle: Text(note['body']),
                onLongPress: () {
                  showNoteOptions(note);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteForm,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NoteForm extends StatefulWidget {
  const NoteForm({super.key, required this.onSaved, this.note});

  final Map<String, dynamic>? note;
  final VoidCallback onSaved;

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  late TextEditingController titleController;
  late TextEditingController bodyController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note?['title'] ?? '');
    bodyController = TextEditingController(text: widget.note?['body'] ?? '');
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  Future<void> saveNote() async {
    String title = titleController.text.trim();
    String body = bodyController.text.trim();

    if (title.isEmpty || body.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter title and body')),
      );
      return;
    }

    try {
      if (widget.note == null) {
        await NoteDatabase.insertNote({
          'title': title,
          'body': body,
          'createdAt': DateTime.now().toString(),
        });
      } else {
        await NoteDatabase.updateNote({
          'id': widget.note!['id'],
          'title': title,
          'body': body,
          'createdAt': widget.note!['createdAt'],
        });
      }

      widget.onSaved();

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Save failed: $error')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: bodyController,
            decoration: const InputDecoration(labelText: 'Body'),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: saveNote, child: const Text('Save')),
        ],
      ),
    );
  }
}
