import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/opportunity.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const List<String> _filters = [
    'All',
    'Jobs',
    'Internships',
    'Scholarships',
  ];

  static final List<Opportunity> _opportunities = List.from(sampleOpportunities);

  List<Opportunity> _filteredBy(String selectedFilter) {
    if (selectedFilter == 'All') return _opportunities;

    final cat = selectedFilter == 'Jobs'
        ? 'Job'
        : selectedFilter == 'Internships'
            ? 'Internship'
            : 'Scholarship';

    return _opportunities.where((o) => o.category == cat).toList();
  }


  void _navigateToEdit(BuildContext context, Opportunity opp) {
    context.push('/edit-opportunity', extra: opp);
  }

  void _navigateToAdd(BuildContext context) {
    context.push('/add-opportunity');
  }

  void _showDeleteNotice(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Delete action is disabled in this view'),
        backgroundColor: ZewgTheme.danger,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const selectedFilter = 'All';
    final filtered = _filteredBy(selectedFilter);

    return Scaffold(
      backgroundColor: ZewgTheme.background,
      bottomNavigationBar: ZewgBottomNav(
        currentIndex: 0,
        onTap: (i) {
          if (i == 1) {
            _navigateToAdd(context);
          }
        },
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'The Academic',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: ZewgTheme.primary,
                      ),
                    ),
                    const Text(
                      'Curator',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: ZewgTheme.primary,
                      ),
                    ),
                    const Text(
                      'ADMIN DASHBOARD',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                        color: ZewgTheme.textMuted,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Welcome back,\nCurator.',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: ZewgTheme.textPrimary,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Manage your academic ecosystem and student opportunities from one central hub.',
                      style: TextStyle(
                        fontSize: 14,
                        color: ZewgTheme.textSecondary,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () => _navigateToAdd(context),
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
                child: Column(
                  children: [
                    StatCard(
                      label: 'Total Posts',
                      value: '${_opportunities.length + 1281}',
                    ),
                    const SizedBox(height: 12),
                    const StatCard(
                      label: 'Pending Approval',
                      value: '42',
                    ),
                    const SizedBox(height: 12),
                    const StatCard(
                      label: 'Active Students',
                      value: '8.6k',
                      dark: true,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Managed Opportunities',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: ZewgTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _filters.map((f) {
                          final selected = selectedFilter == f;

                          return GestureDetector(
                            onTap: () {},
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: selected
                                    ? ZewgTheme.primary
                                    : ZewgTheme.surface,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: selected
                                      ? ZewgTheme.primary
                                      : ZewgTheme.border,
                                ),
                              ),
                              child: Text(
                                f,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: selected
                                      ? Colors.white
                                      : ZewgTheme.textSecondary,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final opp = filtered[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: OpportunityCard(
                        opportunity: opp,
                        onEdit: () => _navigateToEdit(context, opp),
                        onDelete: () => _showDeleteNotice(context),
                      ),
                    );
                  },
                  childCount: filtered.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
