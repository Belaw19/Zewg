import 'package:dio/dio.dart';
import 'package:zewg_admin/core/network/api_client.dart';
import 'package:zewg_admin/features/opportunities/data/datasources/opportunity_local_datasource.dart';
import 'package:zewg_admin/features/opportunities/data/datasources/opportunity_remote_datasource.dart';
import 'package:zewg_admin/features/opportunities/data/repositories/opportunity_repository.dart';
import 'package:zewg_admin/features/opportunities/domain/opportunity.dart';

/// In-memory repository for tests — no network or SQLite.
class FakeOpportunityRepository extends OpportunityRepository {
  FakeOpportunityRepository(List<Opportunity> items)
      : _items = List<Opportunity>.from(items),
        super(
          OpportunityLocalDataSource(),
          OpportunityRemoteDataSource(ApiClient(Dio())),
        );

  final List<Opportunity> _items;

  @override
  Future<List<Opportunity>> getAll() async => List.unmodifiable(_items);

  @override
  Future<List<Opportunity>> refresh() async => List.unmodifiable(_items);

  @override
  Future<Opportunity> create(Opportunity opportunity) async {
    _items.add(opportunity);
    return opportunity;
  }

  @override
  Future<Opportunity> update(Opportunity opportunity) async {
    final index = _items.indexWhere((o) => o.id == opportunity.id);
    if (index != -1) _items[index] = opportunity;
    return opportunity;
  }

  @override
  Future<void> delete(String id) async {
    _items.removeWhere((o) => o.id == id);
  }
}
