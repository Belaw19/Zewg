import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:zewg/core/constants/route_paths.dart';
import 'package:zewg/core/widgets/main_bottom_nav.dart';
import 'package:zewg/core/widgets/opportunity_card.dart';
import 'package:zewg/features/home/presentation/widgets/home_feed_slivers.dart';
import 'package:zewg/features/opportunities/domain/providers/opportunity_provider.dart';

class ZewgScholarshipsPage extends ConsumerWidget {
  const ZewgScholarshipsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scholarshipsProvider);
    final query = ref.watch(searchQueryProvider).toLowerCase().trim();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            buildSliverHeader(context),
            buildSliverSearchAndTitle(ref),
            buildFilterRow(context, 'Scholarships'),
            buildSectionTitle(context, 'Scholarships', viewAllDestination: RoutePaths.homeAll),
            state.when(
              loading: () => const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
              error: (e, _) => SliverFillRemaining(child: Center(child: Text('Error: $e'))),
              data: (scholarships) {
                final shown = filterOpportunitiesByQuery(scholarships, query);
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index == shown.length) return const SizedBox(height: 100);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: OpportunityCard(opportunity: shown[index]),
                        );
                      },
                      childCount: shown.length + 1,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildMainBottomNav(context, isHome: true),
    );
  }
}
