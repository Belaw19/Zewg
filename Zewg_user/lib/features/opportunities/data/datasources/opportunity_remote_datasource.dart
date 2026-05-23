import 'package:zewg/core/constants/api_constants.dart';
import 'package:zewg/core/network/api_client.dart';
import 'package:zewg/features/opportunities/domain/models/opportunity.dart';

class OpportunityRemoteDataSource {
  final ApiClient _client;

  OpportunityRemoteDataSource(this._client);

  Future<List<Opportunity>> fetchAll() async {
    final list = await _client.safeGetList(ApiConstants.opportunities);
    return list.map((e) => Opportunity.fromApi(e as Map<String, dynamic>)).toList();
  }

  Future<Opportunity> fetchById(String id) async {
    final all = await fetchAll();
    return all.firstWhere((o) => o.id == id, orElse: () => throw Exception('Not found'));
  }

  Future<Opportunity> create(Opportunity opportunity) async {
    final data = await _client.safePost(
      ApiConstants.opportunities,
      body: opportunity.toApiBody(),
    );
    return Opportunity.fromApi(data);
  }

  Future<Opportunity> update(Opportunity opportunity) async {
    final data = await _client.safePut(
      '${ApiConstants.opportunities}/${opportunity.id}',
      body: opportunity.toApiBody(),
    );
    return Opportunity.fromApi(data);
  }

  Future<void> delete(String id) async {
    await _client.delete('${ApiConstants.opportunities}/$id');
  }
}
