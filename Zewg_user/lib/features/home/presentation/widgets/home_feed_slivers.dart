import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:zewg/core/constants/route_paths.dart';
import 'package:zewg/features/opportunities/domain/providers/opportunity_provider.dart';

Widget buildSliverHeader(BuildContext context) {
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Zewg',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF004D60))),
          GestureDetector(
            onTap: () => context.go(RoutePaths.profile),
            behavior: HitTestBehavior.opaque,
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE6E9E9))),
              child: const CircleAvatar(
                  backgroundColor: Color(0xFF535B61),
                  child: Icon(Icons.person, color: Colors.white70)),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildSliverSearchAndTitle(WidgetRef ref) {
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                  fontSize: 29.72, fontWeight: FontWeight.w800, color: Color(0xFF1A1C1D)),
              children: [
                TextSpan(text: 'Find your '),
                TextSpan(
                    text: 'future.',
                    style: TextStyle(color: Color(0xFF00677F))),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Curated opportunities for the next\ngeneration of leaders.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Color(0xFF3F484C), height: 1.4),
          ),
          const SizedBox(height: 24),
          TextField(
            onChanged: (v) => ref.read(searchQueryProvider.notifier).state = v,
            decoration: InputDecoration(
              hintText: 'Search roles, companies, or keywords...',
              hintStyle: const TextStyle(color: Colors.black38),
              prefixIcon: const Icon(Icons.search, color: Color(0xFF3F484C)),
              filled: true,
              fillColor: const Color(0xFFE8E8E8),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildFilterRow(BuildContext context, String activeLabel) {
  final ScrollController scrollController = ScrollController();
  final List<String> labels = ['All', 'Jobs', 'Internships', 'Scholarships'];
  final int activeIndex = labels.indexOf(activeLabel);

  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (scrollController.hasClients && activeIndex > 1) {
      scrollController.animateTo(
        activeIndex * 100.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  });

  return SliverToBoxAdapter(
    child: SizedBox(
      height: 50,
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            _buildFilterChip(context, 'All',
                isSelected: activeLabel == 'All', destination: RoutePaths.homeAll),
            _buildFilterChip(context, 'Jobs',
                isSelected: activeLabel == 'Jobs', destination: RoutePaths.jobs),
            _buildFilterChip(context, 'Internships',
                isSelected: activeLabel == 'Internships', destination: RoutePaths.internships),
            _buildFilterChip(context, 'Scholarships',
                isSelected: activeLabel == 'Scholarships', destination: RoutePaths.scholarships),
          ],
        ),
      ),
    ),
  );
}

Widget _buildFilterChip(BuildContext context, String label,
    {required bool isSelected, required String destination}) {
  return GestureDetector(
    onTap: () => context.go(destination),
    child: Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF004D60) : const Color(0xFFD4E5EF),
        borderRadius: BorderRadius.circular(80),
      ),
      child: Text(
        label,
        style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF4A5155),
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget buildSectionTitle(BuildContext context, String title,
    {String? viewAllDestination}) {
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          if (viewAllDestination != null)
            GestureDetector(
              onTap: () => context.go(viewAllDestination),
              behavior: HitTestBehavior.opaque,
              child: const Text('View all',
                  style: TextStyle(color: Color(0xFF005B71), fontWeight: FontWeight.w600)),
            ),
        ],
      ),
    ),
  );
}
