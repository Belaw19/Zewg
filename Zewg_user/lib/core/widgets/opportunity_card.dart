import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:zewg/core/constants/route_paths.dart';
import 'package:zewg/core/theme/app_button_styles.dart';
import 'package:zewg/features/opportunities/domain/models/opportunity.dart';
import 'package:zewg/features/opportunities/domain/providers/opportunity_provider.dart';

class OpportunityCard extends ConsumerWidget {
  final Opportunity opportunity;

  const OpportunityCard({super.key, required this.opportunity});

  Color get _categoryColor {
    switch (opportunity.category) {
      case 'JOB':
        return const Color(0xFFD4E5EF);
      case 'INTERNSHIP':
        return const Color(0xFFA2F1A2);
      case 'SCHOLARSHIP':
        return const Color(0xFFFDE2C4);
      default:
        return const Color(0xFFEDEEF0);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.business, color: Colors.grey),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(opportunity.title,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(opportunity.company,
                        style: const TextStyle(fontSize: 14, color: Colors.black54)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => ref.read(opportunitiesProvider.notifier).toggleSave(opportunity),
                behavior: HitTestBehavior.opaque,
                child: Icon(
                  opportunity.isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: opportunity.isSaved ? const Color(0xFF005BFF) : Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: opportunity.tags.map(_buildTag).toList(),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: _categoryColor, borderRadius: BorderRadius.circular(8)),
            child: Text(
              opportunity.category,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF7A5901)),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, size: 14, color: Colors.black54),
                  const SizedBox(width: 6),
                  Text(
                    opportunity.deadline.isEmpty ? 'Deadline: TBD' : 'Deadline: ${opportunity.deadline}',
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => context.go(RoutePaths.opportunity(opportunity.id)),
                style: primaryInteractiveButtonStyle(
                  backgroundColor: const Color(0xFF005B71),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text('Apply Now', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(color: const Color(0xFFEDEEF0), borderRadius: BorderRadius.circular(8)),
        child: Text(label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF5E676B), fontWeight: FontWeight.w500)),
      );
}
