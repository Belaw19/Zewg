import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static Database? _db;

  static Future<Database> instance() async {
    if (_db != null) return _db!;
    final dbPath = join(await getDatabasesPath(), 'zewg_admin.db');
    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, _) async {
        await db.execute('''
          CREATE TABLE session (
            id INTEGER PRIMARY KEY CHECK (id = 1),
            user_id TEXT NOT NULL,
            user_name TEXT NOT NULL,
            user_email TEXT NOT NULL,
            user_role TEXT NOT NULL,
            token TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE opportunities (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            company TEXT NOT NULL,
            category TEXT NOT NULL,
            location TEXT NOT NULL,
            deadline TEXT NOT NULL,
            description TEXT NOT NULL,
            link TEXT NOT NULL,
            type TEXT NOT NULL,
            created_by TEXT NOT NULL,
            created_at TEXT NOT NULL,
            payload TEXT NOT NULL
          )
        ''');
      },
    );
    return _db!;
  }
}
