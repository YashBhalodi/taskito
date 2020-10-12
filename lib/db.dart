import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskito/classes.dart';
import 'package:taskito/constant.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper.internal();

  factory DBHelper() => _instance;

  DBHelper.internal();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'taskito.db');
    var db = openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE TASKS(id integer primary key autoincrement,title text, note text, date text, done integer,level integer);");
    print("Task table created");
  }

  Future<int> addTask(Task t) async {
    var dbClient = await db;
    t.id = await dbClient.insert('TASKS', t.toMap());
    print("task id ${t.id} added");
    return t.id;
  }

  Future<void> deleteTask(Task t) async {
    var dbClient = await db;
    int deletedRow = await dbClient.delete('TASKS', where: 'id = ?', whereArgs: [t.id]);
    print(deletedRow.toString() + " rows deleted");
  }

  Future<void> updateTask(Task t) async {
    var dbClient = await db;
    int rowUpdated = await dbClient.update('TASKS', t.toMap(), where: 'id = ?', whereArgs: [t.id]);
    print(rowUpdated.toString() + " rows updated");
  }

  Future<List<Task>> getTask(DateTime dateTime) async {
    var dbClient = await db;
    String queryDate = Constant.dateFormatter.format(dateTime);
    List<Map> maps = await dbClient.query('TASKS', where: 'date = ?', whereArgs: [queryDate]);
    List<Task> tasks = [];
    if (maps.length > 0) {
      maps.forEach((map) {
        tasks.add(Task.fromMap(map));
      });
    }
    return tasks;
  }

  Future<List<Task>> searchTask(String searchQuery) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery(
        "SELECT * FROM TASK WHERE title LIKE %$searchQuery% OR note LIKE %$searchQuery%;");
    List<Task> tasks = [];
    if (maps.length > 0) {
      maps.forEach((map) {
        tasks.add(Task.fromMap(map));
      });
    }
    print(tasks.toString());
    return tasks;
  }
}
