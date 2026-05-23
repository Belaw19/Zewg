import 'package:sqflite/sqflite.dart';
import 'package:zewg_admin/core/database/app_database.dart';
import 'package:zewg_admin/features/opportunities/data/mappers/opportunity_mapper.dart';
import 'package:zewg_admin/features/opportunities/domain/opportunity.dart';

class OpportunityLocalDataSource {
  Future<List<Opportunity>> getAll() async {
    final db = await AppDatabase.instance();
    final rows = await db.query('opportunities', orderBy: 'created_at DESC');
    return rows
        .map((r) => OpportunityMapper.fromApi(
              {
                'id': r['id'],
                'title': r['title'],
                'description': r['description'],
                'category': r['category'],
                'company': r['company'],
                'deadline': r['deadline'],
                'location': r['location'],
                'type': r['type'],
                'link': r['link'],
                'createdAt': r['created_at'],
              },
              payload: r['payload'] as String?,
            ))
        .toList();
  }

  Future<void> upsertAll(List<Opportunity> items) async {
    final db = await AppDatabase.instance();
    final batch = db.batch();
    batch.delete('opportunities');
    for (final item in items) {
      batch.insert('opportunities', _row(item), conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  Future<void> upsert(Opportunity item) async {
    final db = await AppDatabase.instance();
    await db.insert('opportunities', _row(item), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> delete(String id) async {
    final db = await AppDatabase.instance();
    await db.delete('opportunities', where: 'id = ?', whereArgs: [id]);
  }

  Map<String, Object?> _row(Opportunity o) {
    final api = OpportunityMapper.toApi(o);
    return {
      'id': o.id,
      'title': o.title,
      'company': o.company,
      'category': api['category'] as String,
      'location': o.location,
      'deadline': api['deadline'] as String,
      'description': o.description,
      'link': o.applicationUrl,
      'type': api['type'] as String,
      'created_by': '',
      'created_at': o.postedAt.toIso8601String(),
      'payload': OpportunityMapper.encodePayload(o),
    };
  }
}
