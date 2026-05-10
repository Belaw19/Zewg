import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../domain/opportunity.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _navIndex = 0;
  String _selectedFilter = 'All';

  final List<String> _filters = [
    'All',
    'Jobs',
    'Internships',
    'Scholarships',
  ];

  final List<Opportunity> _opportunities = List.from(sampleOpportunities);

  List<Opportunity> get _filtered {
    if (_selectedFilter == 'All') return _opportunities;

    final cat = _selectedFilter == 'Jobs'
        ? 'Job'
        : _selectedFilter == 'Internships'
            ? 'Internship'
            : 'Scholarship';

    return _opportunities.where((o) => o.category == cat).toList();
  }

  void _deleteOpportunity(String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Delete Opportunity',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        content: const Text(
          'Are you sure you want to delete this post? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _opportunities.removeWhere((o) => o.id == id);
              });

              Navigator.pop(ctx);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Opportunity deleted'),
                  backgroundColor: ZewgTheme.danger,
                ),
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: ZewgTheme.danger),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToEdit(Opportunity opp) {
    context.push('/edit-opportunity', extra: opp);
  }

  void _navigateToAdd() {
    context.push('/add-opportunity');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZewgTheme.background,
      bottomNavigationBar: ZewgBottomNav(
        currentIndex: _navIndex,
        onTap: (i) {
          if (i == 1) {
            _navigateToAdd();
          } else {
            setState(() => _navIndex = i);
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
                      onPressed: _navigateToAdd,
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
                          final selected = _selectedFilter == f;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedFilter = f;
                              });
                            },
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
                    final opp = _filtered[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: OpportunityCard(
                        opportunity: opp,
                        onEdit: () => _navigateToEdit(opp),
                        onDelete: () => _deleteOpportunity(opp.id),
                      ),
                    );
                  },
                  childCount: _filtered.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
