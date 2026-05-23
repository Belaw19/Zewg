import 'package:zewg_admin/core/constants/api_constants.dart';
import 'package:zewg_admin/core/network/api_client.dart';
import 'package:zewg_admin/features/opportunities/data/mappers/opportunity_mapper.dart';
import 'package:zewg_admin/features/opportunities/domain/opportunity.dart';

class OpportunityRemoteDataSource {
  final ApiClient _client;

  OpportunityRemoteDataSource(this._client);

  Future<List<Opportunity>> fetchAll() async {
    final list = await _client.safeGetList(ApiConstants.opportunities);
    return list.map((e) => OpportunityMapper.fromApi(e as Map<String, dynamic>)).toList();
  }

  Future<Opportunity> create(Opportunity opportunity) async {
    final data = await _client.safePost(
      ApiConstants.opportunities,
      body: OpportunityMapper.toApi(opportunity),
    );
    return OpportunityMapper.fromApi(data);
  }

  Future<Opportunity> update(Opportunity opportunity) async {
    final data = await _client.safePut(
      '${ApiConstants.opportunities}/${opportunity.id}',
      body: OpportunityMapper.toApi(opportunity),
    );
    return OpportunityMapper.fromApi(data);
  }

  Future<void> delete(String id) async {
    await _client.delete('${ApiConstants.opportunities}/$id');
  }
}
