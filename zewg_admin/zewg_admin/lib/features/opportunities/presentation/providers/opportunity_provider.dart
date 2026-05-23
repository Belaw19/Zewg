import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zewg_admin/core/network/api_client.dart';
import 'package:zewg_admin/features/opportunities/data/datasources/opportunity_local_datasource.dart';
import 'package:zewg_admin/features/opportunities/data/datasources/opportunity_remote_datasource.dart';
import 'package:zewg_admin/features/opportunities/data/repositories/opportunity_repository.dart';
import 'package:zewg_admin/features/opportunities/domain/opportunity.dart';

final opportunityRepositoryProvider = Provider<OpportunityRepository>((ref) {
  final client = ref.watch(apiClientProvider);
  return OpportunityRepository(
    OpportunityLocalDataSource(),
    OpportunityRemoteDataSource(client),
  );
});

class AdminOpportunitiesNotifier extends AsyncNotifier<List<Opportunity>> {
  @override
  Future<List<Opportunity>> build() async {
    return ref.read(opportunityRepositoryProvider).getAll();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(opportunityRepositoryProvider).refresh());
  }

  Future<Opportunity?> create(Opportunity draft) async {
    try {
      final created = await ref.read(opportunityRepositoryProvider).create(draft);
      await refresh();
      return created;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<Opportunity?> updateOpportunity(Opportunity opportunity) async {
    try {
      final updated = await ref.read(opportunityRepositoryProvider).update(opportunity);
      await refresh();
      return updated;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<bool> delete(String id) async {
    try {
      await ref.read(opportunityRepositoryProvider).delete(id);
      await refresh();
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}

final adminOpportunitiesProvider =
    AsyncNotifierProvider<AdminOpportunitiesNotifier, List<Opportunity>>(AdminOpportunitiesNotifier.new);
