import 'package:zewg/features/opportunities/data/datasources/opportunity_local_datasource.dart';
import 'package:zewg/features/opportunities/data/datasources/opportunity_remote_datasource.dart';
import 'package:zewg/features/opportunities/domain/models/opportunity.dart';

class OpportunityRepository {
  final OpportunityLocalDataSource _local;
  final OpportunityRemoteDataSource _remote;

  OpportunityRepository(this._local, this._remote);

  Future<List<Opportunity>> getAll() async {
    final cached = await _local.getAll();
    if (cached.isNotEmpty) return cached;
    final remote = await _remote.fetchAll();
    await _local.upsertAll(remote);
    return remote;
  }

  Future<Opportunity> getById(String id) async {
    try {
      final remote = await _remote.fetchById(id);
      final local = await _local.getById(id);
      final merged = remote.copyWith(
        isSaved: local?.isSaved ?? false,
        isApplied: local?.isApplied ?? false,
      );
      await _local.upsert(merged);
      return merged;
    } catch (_) {
      final cached = await _local.getById(id);
      if (cached != null) return cached;
      rethrow;
    }
  }

  Future<List<Opportunity>> getSaved() => _local.getSaved();

  Future<List<Opportunity>> getApplied() => _local.getApplied();

  Future<void> toggleSave(Opportunity opportunity) async {
    final updated = opportunity.copyWith(isSaved: !opportunity.isSaved);
    await _local.upsert(updated);
  }

  Future<void> markApplied(Opportunity opportunity) async {
    final updated = opportunity.copyWith(isApplied: true);
    await _local.upsert(updated);
  }

  Future<List<Opportunity>> refresh() async {
    final remote = await _remote.fetchAll();
    final existing = await _local.getAll();
    final flagMap = {for (final o in existing) o.id: o};
    final merged = remote.map((o) {
      final local = flagMap[o.id];
      if (local == null) return o;
      return o.copyWith(isSaved: local.isSaved, isApplied: local.isApplied);
    }).toList();
    await _local.upsertAll(merged);
    return merged;
  }

  Future<Opportunity> create(Opportunity opportunity) async {
    final created = await _remote.create(opportunity);
    await _local.upsert(created);
    return created;
  }

  Future<Opportunity> update(Opportunity opportunity) async {
    final updated = await _remote.update(opportunity);
    final existing = await _local.getById(opportunity.id);
    final withFlags = updated.copyWith(
      isSaved: existing?.isSaved ?? false,
      isApplied: existing?.isApplied ?? false,
    );
    await _local.upsert(withFlags);
    return withFlags;
  }

  Future<void> delete(String id) async {
    await _remote.delete(id);
    await _local.delete(id);
  }
}
