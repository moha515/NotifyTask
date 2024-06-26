import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'tasks.db');

    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(localId INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, date TEXT, time TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<int> insertTask(String title, DateTime date, TimeOfDay time) async {
    final db = await database;
    return await db.insert(
      'tasks',
      {
        'title': title,
        'date': date.toIso8601String(),
        'time': '${time.hour}:${time.minute}',
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getTask(int localId) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'localId = ?',
      whereArgs: [localId],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }
  
  Future<void> printAllTasks() async {
  final db = await database;
  final List<Map<String, dynamic>> tasks = await db.query('tasks');
  tasks.forEach((task) {
    print('Task: $task');
  });
}Future<int> deleteTask(int localId) async {
    final db = await database;
    return await db.delete(
      'tasks',
      where: 'localId = ?',
      whereArgs: [localId],
    );
  }
}
