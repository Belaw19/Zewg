import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:zewg/core/database/app_database.dart';
import 'package:zewg/features/opportunities/domain/models/opportunity.dart';

class OpportunityLocalDataSource {
  Future<List<Opportunity>> getAll() async {
    final db = await AppDatabase.instance();
    final rows = await db.query('opportunities', orderBy: 'created_at DESC');
    return rows.map(_fromRow).toList();
  }

  Future<Opportunity?> getById(String id) async {
    final db = await AppDatabase.instance();
    final rows = await db.query('opportunities', where: 'id = ?', whereArgs: [id]);
    if (rows.isEmpty) return null;
    return _fromRow(rows.first);
  }

  Future<void> upsertAll(List<Opportunity> items) async {
    final db = await AppDatabase.instance();
    final batch = db.batch();
    batch.delete('opportunities');
    for (final item in items) {
      batch.insert('opportunities', _toRow(item), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  Future<void> upsert(Opportunity item) async {
    final db = await AppDatabase.instance();
    await db.insert('opportunities', _toRow(item), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> delete(String id) async {
    final db = await AppDatabase.instance();
    await db.delete('opportunities', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Opportunity>> getSaved() async {
    final all = await getAll();
    return all.where((o) => o.isSaved).toList();
  }

  Future<List<Opportunity>> getApplied() async {
    final all = await getAll();
    return all.where((o) => o.isApplied).toList();
  }

  Opportunity _fromRow(Map<String, Object?> row) {
    final tagsRaw = row['tags'] as String? ?? '[]';
    final tags = (jsonDecode(tagsRaw) as List<dynamic>).map((e) => e.toString()).toList();
    return Opportunity.fromMap({
      ...row.map((k, v) => MapEntry(k, v)),
      'tags': tags,
    });
  }

  Map<String, Object?> _toRow(Opportunity o) => {
        'id': o.id,
        'title': o.title,
        'company': o.company,
        'category': o.category,
        'location': o.location,
        'deadline': o.deadline,
        'description': o.description,
        'link': o.link,
        'type': o.type,
        'created_by': o.createdBy,
        'created_at': o.createdAt,
        'tags': jsonEncode(o.tags),
        'cover_image_path': o.coverImagePath,
        'is_saved': o.isSaved ? 1 : 0,
        'is_applied': o.isApplied ? 1 : 0,
      };
}
