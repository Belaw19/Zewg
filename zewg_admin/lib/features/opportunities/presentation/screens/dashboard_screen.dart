import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/opportunity.dart';
import '../providers/opportunity_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  static const List<String> _filters = ['All', 'Jobs', 'Internships', 'Scholarships'];
  String _selectedFilter = 'All';

  List<Opportunity> _filteredBy(List<Opportunity> list, String selectedFilter) {
    if (selectedFilter == 'All') return list;
    final cat = selectedFilter == 'Jobs'
        ? 'Job'
        : selectedFilter == 'Internships'
            ? 'Internship'
            : 'Scholarship';
    return list.where((o) => o.category == cat).toList();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminOpportunitiesProvider);
    final auth = ref.watch(authProvider);
    final opportunities = state.asData?.value ?? [];
    final filtered = _filteredBy(opportunities, _selectedFilter);

    return Scaffold(
      backgroundColor: ZewgTheme.background,
      bottomNavigationBar: ZewgBottomNav(
        currentIndex: 0,
        onTap: (i) {
          if (i == 1) context.push('/add-opportunity');
        },
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.read(adminOpportunitiesProvider.notifier).refresh(),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('The Academic', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: ZewgTheme.primary)),
                                const Text('Curator', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: ZewgTheme.primary)),
                                const Text('ADMIN DASHBOARD', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: ZewgTheme.textMuted)),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => ref.read(authProvider.notifier).signOut(),
                            tooltip: 'Log out',
                            icon: const Icon(Icons.logout, color: ZewgTheme.textSecondary),
                          ),
                        ],
                      ),
                      if (auth.user != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Signed in as ${auth.user!.email}',
                          style: const TextStyle(fontSize: 12, color: ZewgTheme.textMuted),
                        ),
                      ],
                      const SizedBox(height: 20),
                      const Text('Welcome back,\nCurator.', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: ZewgTheme.textPrimary, height: 1.2)),
                      const SizedBox(height: 8),
                      const Text('Manage your academic ecosystem and student opportunities from one central hub.', style: TextStyle(fontSize: 14, color: ZewgTheme.textSecondary, height: 1.5)),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () => context.push('/add-opportunity'),
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('New Post'),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: StatCard(label: 'Total Posts', value: '${opportunities.length}'),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Managed Opportunities', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: ZewgTheme.textPrimary)),
                      const SizedBox(height: 12),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _filters.map((f) {
                            final selected = _selectedFilter == f;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedFilter = f),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: selected ? ZewgTheme.primary : ZewgTheme.surface,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: selected ? ZewgTheme.primary : ZewgTheme.border),
                                ),
                                child: Text(f, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: selected ? Colors.white : ZewgTheme.textSecondary)),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              state.when(
                loading: () => const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
                error: (e, _) => SliverFillRemaining(child: Center(child: Text('Error: $e'))),
                data: (_) => SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final opp = filtered[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: OpportunityCard(
                            opportunity: opp,
                            onEdit: () => context.push('/edit-opportunity', extra: opp),
                            onDelete: () async {
                              final ok = await ref.read(adminOpportunitiesProvider.notifier).delete(opp.id);
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(ok ? 'Deleted ${opp.title}' : 'Delete failed'),
                                  backgroundColor: ok ? ZewgTheme.danger : ZewgTheme.textMuted,
                                ),
                              );
                            },
                          ),
                        );
                      },
                      childCount: filtered.length,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
