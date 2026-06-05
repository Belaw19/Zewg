import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zewg/features/opportunities/domain/providers/opportunity_provider.dart';

import '../helpers/fake_opportunity_repository.dart';
import '../helpers/sample_data.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer(
      overrides: [
        opportunityRepositoryProvider.overrideWithValue(
          FakeOpportunityRepository(sampleOpportunities),
        ),
      ],
    );
  });

  tearDown(() => container.dispose());

  group('searchQueryProvider', () {
    test('starts with empty query', () {
      expect(container.read(searchQueryProvider), '');
    });

    test('setQuery updates state', () {
      container.read(searchQueryProvider.notifier).setQuery('flutter');
      expect(container.read(searchQueryProvider), 'flutter');
    });
  });

  group('opportunitiesProvider', () {
    test('loads mock opportunities', () async {
      final list = await container.read(opportunitiesProvider.future);
      expect(list, hasLength(3));
      expect(list.map((o) => o.id), contains('opp-1'));
    });

    test('jobsProvider filters JOB category', () async {
      await container.read(opportunitiesProvider.future);
      final jobs = container.read(jobsProvider).value ?? [];
      expect(jobs, hasLength(1));
      expect(jobs.first.category, 'JOB');
    });
  });

  group('searchResultsProvider', () {
    test('filters by company name', () async {
      await container.read(opportunitiesProvider.future);
      container.read(searchQueryProvider.notifier).setQuery('acme');

      final results = container.read(searchResultsProvider).value ?? [];
      expect(results, hasLength(1));
      expect(results.first.company, 'Acme Corp');
    });

    test('returns full list when query is empty', () async {
      await container.read(opportunitiesProvider.future);
      final results = container.read(searchResultsProvider).value ?? [];
      expect(results, hasLength(3));
    });
  });
}
