import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:zewg/core/constants/route_paths.dart';
import 'package:zewg/features/opportunities/domain/models/opportunity.dart';
import 'package:zewg/features/opportunities/domain/providers/opportunity_provider.dart';

class JourneyPage extends ConsumerWidget {
  const JourneyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedState = ref.watch(savedOpportunitiesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Zewg',
            style: TextStyle(color: Color(0xFF004D61), fontWeight: FontWeight.bold, fontSize: 24)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () => context.go(RoutePaths.profile),
              behavior: HitTestBehavior.opaque,
              child: const CircleAvatar(
                  backgroundColor: Color(0xFFE0E0E0),
                  child: Icon(Icons.person, color: Color(0xFF4A4A4A))),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text('Your Journey',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Color(0xFF1A1A1A))),
            const SizedBox(height: 12),
            const Text('Tracking your curated academic and career opportunities.',
                style: TextStyle(fontSize: 16, color: Color(0xFF555555), height: 1.4)),
            const SizedBox(height: 30),
            _buildToggle(context, isSaved: true),
            const SizedBox(height: 24),
            savedState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Error: $e'),
              data: (saved) => saved.isEmpty
                  ? const _EmptyState(message: 'No saved opportunities yet.\nBrowse and bookmark ones you like!')
                  : Column(
                      children: saved
                          .map((o) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: _OpportunityCard(opportunity: o),
                              ))
                          .toList(),
                    ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, isSaved: true),
    );
  }
}

class AppliedPage extends ConsumerWidget {
  const AppliedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appliedState = ref.watch(appliedOpportunitiesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Zewg',
            style: TextStyle(color: Color(0xFF004D61), fontWeight: FontWeight.bold, fontSize: 24)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () => context.go(RoutePaths.profile),
              behavior: HitTestBehavior.opaque,
              child: const CircleAvatar(
                  backgroundColor: Color(0xFFE0E0E0),
                  child: Icon(Icons.person, color: Color(0xFF4A4A4A))),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text('Your Journey',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Color(0xFF1A1A1A))),
            const SizedBox(height: 12),
            const Text('Tracking your curated academic and career opportunities.',
                style: TextStyle(fontSize: 16, color: Color(0xFF555555), height: 1.4)),
            const SizedBox(height: 30),
            _buildToggle(context, isSaved: false),
            const SizedBox(height: 24),
            appliedState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Error: $e'),
              data: (applied) => applied.isEmpty
                  ? const _EmptyState(message: 'No applications yet.\nApply to opportunities to track them here!')
                  : Column(
                      children: applied
                          .map((o) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: _OpportunityCard(opportunity: o, showAppliedTag: true),
                              ))
                          .toList(),
                    ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, isSaved: false),
    );
  }
}

// ── Shared helpers ────────────────────────────────────────────────────────────

Widget _buildToggle(BuildContext context, {required bool isSaved}) {
  return Container(
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(color: const Color(0xFFF0F0F2), borderRadius: BorderRadius.circular(12)),
    child: Row(
      children: [
        Expanded(child: _toggleItem(context, 'Saved', isSaved, () => context.go(RoutePaths.journey))),
        Expanded(child: _toggleItem(context, 'Applied', !isSaved, () => context.go(RoutePaths.applied))),
      ],
    ),
  );
}

Widget _toggleItem(BuildContext context, String label, bool isActive, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: isActive
          ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)])
          : null,
      child: Center(
        child: Text(
          label,
          style: TextStyle(
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? const Color(0xFF004D61) : const Color(0xFF666666)),
        ),
      ),
    ),
  );
}

Widget _buildBottomNav(BuildContext context, {required bool isSaved}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12),
    decoration: const BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _navItem(Icons.home_outlined, 'HOME', false, () => context.go(RoutePaths.homeAll)),
        _navItem(Icons.bookmark, 'SAVED', true, () => context.go(RoutePaths.journey)),
        _navItem(Icons.person_outline, 'PROFILE', false, () => context.go(RoutePaths.profile)),
      ],
    ),
  );
}

Widget _navItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: isActive
          ? BoxDecoration(color: const Color(0xFF006B7D), borderRadius: BorderRadius.circular(12))
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isActive ? Colors.white : Colors.grey),
          const SizedBox(height: 4),
          Text(label,
              style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}

class _EmptyState extends StatelessWidget {
  final String message;
  const _EmptyState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          children: [
            const Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 16, height: 1.5)),
          ],
        ),
      ),
    );
  }
}

class _OpportunityCard extends ConsumerWidget {
  final Opportunity opportunity;
  final bool showAppliedTag;

  const _OpportunityCard({required this.opportunity, this.showAppliedTag = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEEEEEE))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: const Color(0xFFD9E9F2), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.work_outline, color: Color(0xFF4A4A4A)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(opportunity.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(opportunity.company, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          if (showAppliedTag)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: const Color(0xFF004D61), borderRadius: BorderRadius.circular(20)),
              child: const Text('APPLIED',
                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            )
          else
            GestureDetector(
              onTap: () => ref.read(opportunitiesProvider.notifier).toggleSave(opportunity),
              child: Icon(
                opportunity.isSaved ? Icons.bookmark : Icons.bookmark_border,
                color: opportunity.isSaved ? const Color(0xFF005BFF) : Colors.grey,
              ),
            ),
        ],
      ),
    );
  }
}
