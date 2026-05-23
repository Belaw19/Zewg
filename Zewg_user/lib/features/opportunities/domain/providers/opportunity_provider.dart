import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zewg/core/network/api_client.dart';
import 'package:zewg/features/opportunities/data/datasources/opportunity_local_datasource.dart';
import 'package:zewg/features/opportunities/data/datasources/opportunity_remote_datasource.dart';
import 'package:zewg/features/opportunities/data/repositories/opportunity_repository.dart';
import 'package:zewg/features/opportunities/domain/models/opportunity.dart';

final opportunityRepositoryProvider = Provider<OpportunityRepository>((ref) {
  final client = ref.watch(apiClientProvider);
  return OpportunityRepository(
    OpportunityLocalDataSource(),
    OpportunityRemoteDataSource(client),
  );
});

class OpportunitiesNotifier extends AsyncNotifier<List<Opportunity>> {
  @override
  Future<List<Opportunity>> build() async {
    try {
      return await ref.read(opportunityRepositoryProvider).refresh();
    } catch (_) {
      return ref.read(opportunityRepositoryProvider).getAll();
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(opportunityRepositoryProvider).refresh(),
    );
  }

  Future<void> toggleSave(Opportunity opportunity) async {
    await ref.read(opportunityRepositoryProvider).toggleSave(opportunity);
    final current = state.asData?.value;
    if (current != null) {
      state = AsyncData(
        current
            .map((o) => o.id == opportunity.id ? o.copyWith(isSaved: !o.isSaved) : o)
            .toList(),
      );
    }
  }

  Future<void> markApplied(Opportunity opportunity) async {
    await ref.read(opportunityRepositoryProvider).markApplied(opportunity);
    final current = state.asData?.value;
    if (current != null) {
      state = AsyncData(
        current.map((o) => o.id == opportunity.id ? o.copyWith(isApplied: true) : o).toList(),
      );
    }
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

final opportunitiesProvider =
    AsyncNotifierProvider<OpportunitiesNotifier, List<Opportunity>>(OpportunitiesNotifier.new);

final jobsProvider = Provider<AsyncValue<List<Opportunity>>>((ref) {
  return ref.watch(opportunitiesProvider).whenData(
        (list) => list.where((o) => o.category == 'JOB').toList(),
      );
});

final internshipsProvider = Provider<AsyncValue<List<Opportunity>>>((ref) {
  return ref.watch(opportunitiesProvider).whenData(
        (list) => list.where((o) => o.category == 'INTERNSHIP').toList(),
      );
});

final scholarshipsProvider = Provider<AsyncValue<List<Opportunity>>>((ref) {
  return ref.watch(opportunitiesProvider).whenData(
        (list) => list.where((o) => o.category == 'SCHOLARSHIP').toList(),
      );
});

final savedOpportunitiesProvider = Provider<AsyncValue<List<Opportunity>>>((ref) {
  return ref.watch(opportunitiesProvider).whenData(
        (list) => list.where((o) => o.isSaved).toList(),
      );
});

final appliedOpportunitiesProvider = Provider<AsyncValue<List<Opportunity>>>((ref) {
  return ref.watch(opportunitiesProvider).whenData(
        (list) => list.where((o) => o.isApplied).toList(),
      );
});

final opportunityByIdProvider = FutureProvider.family<Opportunity, String>((ref, id) async {
  ref.watch(opportunitiesProvider);
  return ref.read(opportunityRepositoryProvider).getById(id);
});

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String value) => state = value;
}

final searchQueryProvider =
    NotifierProvider<SearchQueryNotifier, String>(SearchQueryNotifier.new);

final searchResultsProvider = Provider<AsyncValue<List<Opportunity>>>((ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase().trim();
  final listAsync = ref.watch(opportunitiesProvider);

  return listAsync.when(
    data: (list) {
      if (query.isEmpty) return AsyncData(list);
      return AsyncData(
        list
            .where((o) =>
                o.title.toLowerCase().contains(query) ||
                o.company.toLowerCase().contains(query) ||
                o.tags.any((t) => t.toLowerCase().contains(query)))
            .toList(),
      );
    },
    loading: () => const AsyncLoading(),
    error: (e, st) => AsyncError(e, st),
  );
});
