import 'package:zewg/features/opportunities/data/datasources/opportunity_local_datasource.dart';
import 'package:zewg/features/opportunities/data/datasources/opportunity_remote_datasource.dart';
import 'package:zewg/features/opportunities/domain/models/opportunity.dart';

class OpportunityRepository {
  final OpportunityLocalDataSource _local;
  final OpportunityRemoteDataSource _remote;

  OpportunityRepository(this._local, this._remote);

  /// Cache-first: returns local data if available, otherwise fetches from remote.
  Future<List<Opportunity>> getAll() async {
    final cached = await _local.getAll();
    if (cached.isNotEmpty) return cached;
    final remote = await _remote.fetchAll();
    await _local.upsertAll(remote);
    return remote;
  }

  /// Cache-first for single opportunity.
  Future<Opportunity> getById(String id) async {
    final cached = await _local.getById(id);
    if (cached != null) return cached;
    final remote = await _remote.fetchById(id);
    await _local.upsert(remote);
    return remote;
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

  /// Force refresh from remote (pull-to-refresh).
  Future<List<Opportunity>> refresh() async {
    final remote = await _remote.fetchAll();
    // Preserve local saved/applied flags when refreshing
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
}
