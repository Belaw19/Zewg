import 'package:zewg_admin/features/opportunities/data/datasources/opportunity_local_datasource.dart';
import 'package:zewg_admin/features/opportunities/data/datasources/opportunity_remote_datasource.dart';
import 'package:zewg_admin/features/opportunities/domain/opportunity.dart';

class OpportunityRepository {
  final OpportunityLocalDataSource _local;
  final OpportunityRemoteDataSource _remote;

  OpportunityRepository(this._local, this._remote);

  Future<List<Opportunity>> getAll() async {
    try {
      return await refresh();
    } catch (_) {
      return _local.getAll();
    }
  }

  Future<List<Opportunity>> refresh() async {
    final remote = await _remote.fetchAll();
    await _local.upsertAll(remote);
    return remote;
  }

  Future<Opportunity> create(Opportunity opportunity) async {
    final created = await _remote.create(opportunity);
    await _local.upsert(created);
    return created;
  }

  Future<Opportunity> update(Opportunity opportunity) async {
    final updated = await _remote.update(opportunity);
    await _local.upsert(updated);
    return updated;
  }

  Future<void> delete(String id) async {
    await _remote.delete(id);
    await _local.delete(id);
  }
}
