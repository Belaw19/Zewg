import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zewg/features/opportunities/domain/models/opportunity.dart';

class OpportunityLocalDataSource {
  static const _key = 'opportunities_cache';

  Future<List<Opportunity>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => Opportunity.fromMap(e as Map<String, dynamic>)).toList();
  }

  Future<Opportunity?> getById(String id) async {
    final all = await getAll();
    try {
      return all.firstWhere((o) => o.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<void> upsertAll(List<Opportunity> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(items.map((o) => o.toMap()).toList()));
  }

  Future<void> upsert(Opportunity item) async {
    final all = await getAll();
    final idx = all.indexWhere((o) => o.id == item.id);
    final updated = List<Opportunity>.from(all);
    if (idx >= 0) {
      updated[idx] = item;
    } else {
      updated.add(item);
    }
    await upsertAll(updated);
  }

  Future<List<Opportunity>> getSaved() async {
    final all = await getAll();
    return all.where((o) => o.isSaved).toList();
  }

  Future<List<Opportunity>> getApplied() async {
    final all = await getAll();
    return all.where((o) => o.isApplied).toList();
  }
}
