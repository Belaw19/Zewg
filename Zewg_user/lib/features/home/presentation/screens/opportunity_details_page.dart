import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:zewg/core/constants/route_paths.dart';
import 'package:zewg/core/routing/navigation_helpers.dart';
import 'package:zewg/core/theme/app_button_styles.dart';
import 'package:zewg/features/opportunities/domain/models/opportunity.dart';
import 'package:zewg/features/opportunities/domain/providers/opportunity_provider.dart';

class OpportunityDetails extends ConsumerWidget {
  final String id;
  const OpportunityDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncOpp = ref.watch(opportunityByIdProvider(id));

    return asyncOpp.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (opp) => _DetailsView(opp: opp),
    );
  }
}

class _DetailsView extends ConsumerWidget {
  final Opportunity opp;
  const _DetailsView({required this.opp});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F8FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF004D40)),
          onPressed: () => popOrGo(context, RoutePaths.homeAll),
        ),
        title: const Text('Zewg',
            style: TextStyle(color: Color(0xFF004D40), fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () => context.go(RoutePaths.profile),
              behavior: HitTestBehavior.opaque,
              child: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: const Icon(Icons.person, color: Colors.white)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(),
            const SizedBox(height: 20),
            _buildInfoCard(Icons.business_outlined, 'ORGANIZATION', opp.company),
            _buildInfoCard(Icons.calendar_today_outlined, 'DEADLINE',
                opp.deadline.isEmpty ? 'TBD' : opp.deadline),
            _buildInfoCard(Icons.location_on_outlined, 'LOCATION', opp.location),
            const SizedBox(height: 30),
            const Text('About the Opportunity',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
            const SizedBox(height: 12),
            Text(opp.description,
                style: const TextStyle(color: Colors.black54, height: 1.5)),
            const SizedBox(height: 30),
            const Text('Link',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
              child: Text(opp.link, style: const TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: opp.isApplied
                    ? null
                    : () async {
                        await ref
                            .read(opportunitiesProvider.notifier)
                            .markApplied(opp);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Marked as applied!')),
                          );
                        }
                      },
                style: primaryInteractiveButtonStyle(
                  backgroundColor:
                      opp.isApplied ? Colors.grey : const Color(0xFF004D40),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(opp.isApplied ? 'Applied ✓' : 'Mark as Applied',
                        style: const TextStyle(color: Colors.white, fontSize: 16)),
                    if (!opp.isApplied) ...[
                      const SizedBox(width: 8),
                      const Icon(Icons.open_in_new, size: 18, color: Colors.white),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    final Color bg;
    final Color tagBg;
    final Color tagText;
    switch (opp.category) {
      case 'JOB':
        bg = const Color(0xFF002F4F);
        tagBg = const Color(0xFFD4E5EF);
        tagText = const Color(0xFF004D61);
        break;
      case 'INTERNSHIP':
        bg = const Color(0xFF1A3D2F);
        tagBg = const Color(0xFFA2F1A2);
        tagText = const Color(0xFF1A5C1A);
        break;
      default:
        bg = const Color(0xFF002F2F);
        tagBg = const Color(0xFFD1C4E9);
        tagText = const Color(0xFF512DA8);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: tagBg, borderRadius: BorderRadius.circular(4)),
            child: Text(opp.category,
                style: TextStyle(color: tagText, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          Text(opp.title,
              style: const TextStyle(
                  color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, height: 1.2)),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: const Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: const Color(0xFF00796B)),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 1.1)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            ],
          ),
        ],
      ),
    );
  }
}
