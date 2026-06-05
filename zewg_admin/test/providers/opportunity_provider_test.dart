import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zewg_admin/features/auth/domain/models/user_model.dart';
import 'package:zewg_admin/features/auth/presentation/providers/auth_provider.dart';
import 'package:zewg_admin/features/opportunities/presentation/providers/opportunity_provider.dart';

import '../helpers/fake_auth_repository.dart';
import '../helpers/fake_opportunity_repository.dart';
import '../helpers/sample_data.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer(
      overrides: [
        opportunityRepositoryProvider.overrideWithValue(
          FakeOpportunityRepository(testOpportunities),
        ),
        authRepositoryProvider.overrideWithValue(
          FakeAuthRepository(user: sampleCurator),
        ),
      ],
    );
  });

  tearDown(() => container.dispose());

  group('adminOpportunitiesProvider', () {
    test('loads mock opportunities', () async {
      final list = await container.read(adminOpportunitiesProvider.future);
      expect(list, hasLength(3));
      expect(list.map((o) => o.id), contains('opp-1'));
    });

    test('list contains each category type', () async {
      final list = await container.read(adminOpportunitiesProvider.future);
      final categories = list.map((o) => o.category).toSet();
      expect(categories, containsAll(['Internship', 'Job', 'Scholarship']));
    });
  });

  group('authProvider', () {
    test('signIn authenticates curator', () async {
      while (container.read(authProvider).isLoading) {
        await Future<void>.delayed(Duration.zero);
      }

      final ok = await container.read(authProvider.notifier).signIn(
            sampleCurator.email,
            'password123',
          );

      expect(ok, isTrue);
      expect(container.read(authProvider).isAuthenticated, isTrue);
      expect(container.read(authProvider).user?.email, sampleCurator.email);
    });

    test('non-curator user is not authenticated', () async {
      final studentContainer = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(
            FakeAuthRepository(
              user: UserModel(
                id: 's-1',
                name: 'Student',
                email: 'student@zewg.com',
                role: 'student',
              ),
            ),
          ),
        ],
      );
      addTearDown(studentContainer.dispose);

      while (studentContainer.read(authProvider).isLoading) {
        await Future<void>.delayed(Duration.zero);
      }

      await studentContainer.read(authProvider.notifier).signIn('student@zewg.com', 'pass');
      expect(studentContainer.read(authProvider).isAuthenticated, isFalse);
    });
  });
}
