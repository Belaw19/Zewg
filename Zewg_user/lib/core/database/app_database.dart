import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static Database? _db;

  static Future<Database> instance() async {
    if (_db != null) return _db!;
    final dbPath = join(await getDatabasesPath(), 'zewg.db');
    _db = await openDatabase(
      dbPath,
      version: 2,
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
            tags TEXT NOT NULL DEFAULT '[]',
            cover_image_path TEXT NOT NULL DEFAULT '',
            is_saved INTEGER NOT NULL DEFAULT 0,
            is_applied INTEGER NOT NULL DEFAULT 0
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            "ALTER TABLE opportunities ADD COLUMN cover_image_path TEXT NOT NULL DEFAULT ''",
          );
        }
      },
    );
    return _db!;
  }
}
