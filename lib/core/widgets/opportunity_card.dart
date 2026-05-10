import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:zewg/core/constants/route_paths.dart';
import 'package:zewg/core/theme/app_button_styles.dart';

class OpportunityCard extends StatelessWidget {
  final String title;
  final String company;
  final List<String> tags;
  final String category;
  final Color categoryColor;
  final String deadline;
  final String bookmarkKey;

  static final Map<String, ValueNotifier<bool>> _bookmarkStates = <String, ValueNotifier<bool>>{};

  const OpportunityCard({
    super.key,
    required this.title,
    required this.company,
    required this.tags,
    required this.category,
    required this.categoryColor,
    required this.deadline,
    required this.bookmarkKey,
  });

  ValueNotifier<bool> _bookmarkNotifier() {
    return _bookmarkStates.putIfAbsent(bookmarkKey, () => ValueNotifier<bool>(false));
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> bookmarkNotifier = _bookmarkNotifier();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
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
                decoration: BoxDecoration(
                  color: Colors.grey.shade100, 
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.business, color: Colors.grey),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(company, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => bookmarkNotifier.value = !bookmarkNotifier.value,
                behavior: HitTestBehavior.opaque,
                child: ValueListenableBuilder<bool>(
                  valueListenable: bookmarkNotifier,
                  builder: (context, isBookmarked, _) {
                    return Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: isBookmarked ? const Color(0xFF005BFF) : Colors.black87,
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(spacing: 8, runSpacing: 8, children: tags.map((t) => _buildTag(t)).toList()),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: categoryColor, borderRadius: BorderRadius.circular(8)),
            child: Text(
              category, 
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
                    deadline.isEmpty ? 'Deadline: TBD' : 'Deadline: $deadline', 
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => context.go(RoutePaths.opportunity('1')),
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

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: const Color(0xFFEDEEF0), borderRadius: BorderRadius.circular(8)),
      child: Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF5E676B), fontWeight: FontWeight.w500)),
    );
  }
}
