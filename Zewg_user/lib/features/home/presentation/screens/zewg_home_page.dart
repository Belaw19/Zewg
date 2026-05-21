import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:zewg/core/widgets/main_bottom_nav.dart';
import 'package:zewg/core/widgets/opportunity_card.dart';
import 'package:zewg/features/home/presentation/widgets/home_feed_slivers.dart';
import 'package:zewg/features/opportunities/domain/providers/opportunity_provider.dart';

class ZewgHomePage extends ConsumerWidget {
  const ZewgHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(opportunitiesProvider);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.read(opportunitiesProvider.notifier).refresh(),
          child: CustomScrollView(
            slivers: [
              buildSliverHeader(context),
              buildSliverSearchAndTitle(ref),
              buildFilterRow(context, 'All'),
              buildSectionTitle(context, 'Featured Opportunities'),
              state.when(
                loading: () => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, _) => SliverFillRemaining(
                  child: Center(child: Text('Error: $e')),
                ),
                data: (opportunities) => SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index == opportunities.length) return const SizedBox(height: 100);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: OpportunityCard(opportunity: opportunities[index]),
                        );
                      },
                      childCount: opportunities.length + 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildMainBottomNav(context, isHome: true),
    );
  }
}
