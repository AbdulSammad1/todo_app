import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/task.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await dataBase();
    return _database!;
  }

  static Future<sql.Database> dataBase() async {
    final dbPath = await sql.getDatabasesPath();

    return await sql.openDatabase(
      path.join(dbPath, 'tasks1.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE usertasks(id TEXT PRIMARY KEY, title TEXT, completed INTEGER)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.dataBase();

    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    await db.close();
  }

  static Future<void> updateTask(Task task) async {
    final db = await DBHelper.dataBase();

    await db.update(
      'usertasks',
      {
        'title': task.title,
        'completed': task.completed ? 1 : 0,
      },
      where: 'id=?',
      whereArgs: [task.id],
    );
    await db.close();
  }

  static Future<void> deleteData(String table, String id) async {
    final db = await DBHelper.dataBase();

    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.dataBase();

    return db.query(table);
  }

  static Future<List<Map<String, dynamic>>> getUncompletedTasks(
      String table, int d) async {
    final db = await DBHelper.dataBase();

    return await db.query(table, where: 'completed = ?', whereArgs: [d]);
  }

  static Stream<List<Task>> getUncompletedTasksStream(String table, int d) {
    final db = _database!;

    return db
        .query(table, where: 'completed = ?', whereArgs: [d])
        .asStream()
        .map(
          (tasksList) {
            return tasksList.map((taskMap) {
              return Task.fromMap(taskMap);
            }).toList();
          },
        );
  }
}
