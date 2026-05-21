import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zewg/features/opportunities/data/datasources/opportunity_local_datasource.dart';
import 'package:zewg/features/opportunities/data/datasources/opportunity_remote_datasource.dart';
import 'package:zewg/features/opportunities/data/repositories/opportunity_repository.dart';
import 'package:zewg/features/opportunities/domain/models/opportunity.dart';

// ── Repository provider ──────────────────────────────────────────────────────

final opportunityRepositoryProvider = Provider<OpportunityRepository>((ref) {
  return OpportunityRepository(
    OpportunityLocalDataSource(),
    OpportunityRemoteDataSource(),
  );
});

// ── All opportunities ────────────────────────────────────────────────────────

class OpportunitiesNotifier extends StateNotifier<AsyncValue<List<Opportunity>>> {
  final OpportunityRepository _repo;

  OpportunitiesNotifier(this._repo) : super(const AsyncValue.loading()) {
    load();
  }

  Future<void> load() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repo.getAll();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    try {
      final data = await _repo.refresh();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleSave(Opportunity opportunity) async {
    await _repo.toggleSave(opportunity);
    await load();
  }

  Future<void> markApplied(Opportunity opportunity) async {
    await _repo.markApplied(opportunity);
    await load();
  }
}

final opportunitiesProvider =
    StateNotifierProvider<OpportunitiesNotifier, AsyncValue<List<Opportunity>>>((ref) {
  return OpportunitiesNotifier(ref.watch(opportunityRepositoryProvider));
});

// ── Filtered providers ───────────────────────────────────────────────────────

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

// ── Single opportunity by id ─────────────────────────────────────────────────

final opportunityByIdProvider =
    FutureProvider.family<Opportunity, String>((ref, id) async {
  // First try from the already-loaded list (cache hit in memory)
  final listState = ref.watch(opportunitiesProvider);
  if (listState is AsyncData<List<Opportunity>>) {
    final found = listState.value.where((o) => o.id == id);
    if (found.isNotEmpty) return found.first;
  }
  return ref.watch(opportunityRepositoryProvider).getById(id);
});

// ── Search ───────────────────────────────────────────────────────────────────

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = Provider<AsyncValue<List<Opportunity>>>((ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase().trim();
  return ref.watch(opportunitiesProvider).whenData((list) {
    if (query.isEmpty) return list;
    return list
        .where((o) =>
            o.title.toLowerCase().contains(query) ||
            o.company.toLowerCase().contains(query) ||
            o.tags.any((t) => t.toLowerCase().contains(query)))
        .toList();
  });
});
