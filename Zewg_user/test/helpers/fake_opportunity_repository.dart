import 'package:dio/dio.dart';
import 'package:zewg/core/network/api_client.dart';
import 'package:zewg/features/opportunities/data/datasources/opportunity_local_datasource.dart';
import 'package:zewg/features/opportunities/data/datasources/opportunity_remote_datasource.dart';
import 'package:zewg/features/opportunities/data/repositories/opportunity_repository.dart';
import 'package:zewg/features/opportunities/domain/models/opportunity.dart';

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
  Future<Opportunity> getById(String id) async {
    return _items.firstWhere((o) => o.id == id);
  }

  @override
  Future<void> toggleSave(Opportunity opportunity) async {
    final index = _items.indexWhere((o) => o.id == opportunity.id);
    if (index == -1) return;
    _items[index] = opportunity.copyWith(isSaved: !opportunity.isSaved);
  }

  @override
  Future<void> markApplied(Opportunity opportunity) async {
    final index = _items.indexWhere((o) => o.id == opportunity.id);
    if (index == -1) return;
    _items[index] = opportunity.copyWith(isApplied: true);
  }
}
