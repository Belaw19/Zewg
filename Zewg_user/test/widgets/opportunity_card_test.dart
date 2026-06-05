import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:zewg/core/widgets/opportunity_card.dart';
import 'package:zewg/features/opportunities/domain/providers/opportunity_provider.dart';

import '../helpers/fake_opportunity_repository.dart';
import '../helpers/sample_data.dart';

void main() {
  testWidgets('OpportunityCard shows title, company, and apply button', (tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => Scaffold(
            body: OpportunityCard(opportunity: sampleInternship),
          ),
        ),
        GoRoute(
          path: '/opportunities/:id',
          builder: (_, __) => const Scaffold(body: Text('details')),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          opportunityRepositoryProvider.overrideWithValue(
            FakeOpportunityRepository(sampleOpportunities),
          ),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Flutter Developer Intern'), findsOneWidget);
    expect(find.text('Acme Corp'), findsOneWidget);
    expect(find.text('Apply Now'), findsOneWidget);
    expect(find.text('INTERNSHIP'), findsOneWidget);
  });
}
