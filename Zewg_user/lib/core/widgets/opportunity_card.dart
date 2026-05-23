import 'dart:convert';
import 'dart:io';

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        constraints: const BoxConstraints(minHeight: 220),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Positioned.fill(child: _CardBackground(coverPath: opportunity.coverImagePath, category: opportunity.category)),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.35),
                      Colors.black.withOpacity(0.55),
                      Colors.black.withOpacity(0.82),
                    ],
                    stops: const [0.0, 0.45, 1.0],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _CategoryChip(label: opportunity.category),
                            const SizedBox(height: 10),
                            Text(
                              opportunity.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              opportunity.company,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => ref.read(opportunitiesProvider.notifier).toggleSave(opportunity),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.35),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            opportunity.isSaved ? Icons.bookmark : Icons.bookmark_border,
                            color: opportunity.isSaved ? const Color(0xFF7DD3FC) : Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (opportunity.tags.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: opportunity.tags.take(3).map(_buildTag).toList(),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 14, color: Colors.white.withOpacity(0.85)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          opportunity.deadline.isEmpty ? 'Deadline: TBD' : 'Deadline: ${opportunity.deadline}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () => context.go(RoutePaths.opportunity(opportunity.id)),
                        style: primaryInteractiveButtonStyle(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF004D61),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        ),
                        child: const Text('Apply Now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String label) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.18),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withOpacity(0.28)),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      );
}

class _CategoryChip extends StatelessWidget {
  final String label;

  const _CategoryChip({required this.label});

  Color get _accent {
    switch (label.toUpperCase()) {
      case 'JOB':
        return const Color(0xFF7DD3FC);
      case 'INTERNSHIP':
        return const Color(0xFF86EFAC);
      default:
        return const Color(0xFFFCD34D);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _accent.withOpacity(0.25),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _accent.withOpacity(0.6)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: _accent, letterSpacing: 0.5),
      ),
    );
  }
}

/// Full-bleed card background (no separate foreground image widget).
class _CardBackground extends StatelessWidget {
  final String coverPath;
  final String category;

  const _CardBackground({required this.coverPath, required this.category});

  static const _b64Prefix = 'b64:';

  @override
  Widget build(BuildContext context) {
    final image = _buildImage();
    if (image != null) return image;
    return _placeholder();
  }

  Widget? _buildImage() {
    if (coverPath.trim().isEmpty) return null;
    final value = coverPath.trim();

    if (value.startsWith(_b64Prefix)) {
      try {
        final bytes = base64Decode(value.substring(_b64Prefix.length));
        return Image.memory(bytes, fit: BoxFit.cover, width: double.infinity, height: double.infinity);
      } catch (_) {
        return null;
      }
    }

    if (value.startsWith('http://') || value.startsWith('https://')) {
      return Image.network(
        value,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    }

    if (value.startsWith('assets/')) {
      return Image.asset(value, fit: BoxFit.cover, width: double.infinity, height: double.infinity);
    }

    final file = File(value);
    if (file.existsSync()) {
      return Image.file(file, fit: BoxFit.cover, width: double.infinity, height: double.infinity);
    }

    return null;
  }

  Widget _placeholder() {
    final List<Color> colors;
    switch (category.toUpperCase()) {
      case 'JOB':
        colors = [const Color(0xFF0F4C5C), const Color(0xFF1A6B7A)];
        break;
      case 'INTERNSHIP':
        colors = [const Color(0xFF1B4332), const Color(0xFF2D6A4F)];
        break;
      case 'SCHOLARSHIP':
        colors = [const Color(0xFF5C3D2E), const Color(0xFF8B5E3C)];
        break;
      default:
        colors = [const Color(0xFF374151), const Color(0xFF4B5563)];
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: Center(
        child: Icon(Icons.school_outlined, size: 56, color: Colors.white.withOpacity(0.35)),
      ),
    );
  }
}
