import 'package:sqflite/sqflite.dart';
import 'package:zewg_admin/core/database/app_database.dart';
import 'package:zewg_admin/features/auth/domain/models/user_model.dart';

class AuthLocalDataSource {
  Future<UserModel?> getUser() async {
    final db = await AppDatabase.instance();
    final rows = await db.query('session', where: 'id = ?', whereArgs: [1]);
    if (rows.isEmpty) return null;
    final row = rows.first;
    return UserModel(
      id: row['user_id'] as String,
      name: row['user_name'] as String,
      email: row['user_email'] as String,
      role: row['user_role'] as String,
      token: row['token'] as String,
    );
  }

  Future<void> saveUser(UserModel user) async {
    final db = await AppDatabase.instance();
    await db.insert(
      'session',
      {
        'id': 1,
        'user_id': user.id,
        'user_name': user.name,
        'user_email': user.email,
        'user_role': user.role,
        'token': user.token ?? '',
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> clearUser() async {
    final db = await AppDatabase.instance();
    await db.delete('session', where: 'id = ?', whereArgs: [1]);
  }
}
