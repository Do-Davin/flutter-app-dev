import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class NoteDatabase {
  static Database? _database;
  static bool _ready = false;

  static Future<Database> get database async {
    setupDatabase();

    if (_database != null) {
      return _database!;
    }

    _database = await _initDB();
    return _database!;
  }

  static void setupDatabase() {
    if (_ready) {
      return;
    }

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    _ready = true;
  }

  static Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'notes.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, body TEXT, createdAt TEXT)',
        );
      },
    );
  }

  static Future<int> insertNote(Map<String, dynamic> note) async {
    Database db = await database;
    return db.insert('notes', note);
  }

  static Future<List<Map<String, dynamic>>> getAllNotes() async {
    Database db = await database;
    return db.query('notes', orderBy: 'id DESC');
  }

  static Future<int> updateNote(Map<String, dynamic> note) async {
    Database db = await database;
    return db.update('notes', note, where: 'id = ?', whereArgs: [note['id']]);
  }

  static Future<int> deleteNote(int id) async {
    Database db = await database;
    return db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
