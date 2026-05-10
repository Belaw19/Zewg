import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../../features/opportunities/domain/opportunity.dart';

// ── Category Badge ──────────────────────────────────────────────────────────
class CategoryBadge extends StatelessWidget {
  final String label;
  const CategoryBadge({super.key, required this.label});

  Color get _color {
    switch (label.toLowerCase()) {
      case 'internship':
        return ZewgTheme.badgeInternship;
      case 'scholarship':
        return ZewgTheme.badgeScholarship;
      default:
        return ZewgTheme.badgeJob;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8),
      ),
    );
  }
}

// ── Tag Chip ─────────────────────────────────────────────────────────────────
class TagChip extends StatelessWidget {
  final String label;
  const TagChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: ZewgTheme.inputFill,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ZewgTheme.border),
      ),
      child: Text(label,
          style: const TextStyle(
              fontSize: 12,
              color: ZewgTheme.textSecondary,
              fontWeight: FontWeight.w500)),
    );
  }
}

// ── Stat Card ─────────────────────────────────────────────────────────────────
class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final bool dark;

  const StatCard(
      {super.key, required this.label, required this.value, this.dark = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: dark ? ZewgTheme.primary : ZewgTheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
              color: dark ? Colors.white70 : ZewgTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: dark
                  ? Colors.white
                  : (label == 'PENDING APPROVAL'
                      ? ZewgTheme.pendingOrange
                      : ZewgTheme.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Opportunity Card ──────────────────────────────────────────────────────────
class OpportunityCard extends StatelessWidget {
  final Opportunity opportunity;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const OpportunityCard({
    super.key,
    required this.opportunity,
    required this.onEdit,
    required this.onDelete,
  });

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return 'Posted ${diff.inMinutes}m ago';
    if (diff.inHours < 24) return 'Posted ${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Posted yesterday';
    return 'Posted ${diff.inDays} days ago';
  }

  String _formatViews(int v) {
    if (v >= 1000) return '${(v / 1000).toStringAsFixed(1)}k views';
    return '$v views';
  }

  @override
  Widget build(BuildContext context) {
    final isNew = DateTime.now().difference(opportunity.postedAt).inHours < 24;

    return Container(
      decoration: BoxDecoration(
        color: ZewgTheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover image area
          Stack(
            children: [
              SizedBox(
                height: 180,
                width: double.infinity,
                child: opportunity.coverImagePath != null &&
                        opportunity.coverImagePath!.isNotEmpty
                    ? Image.asset(
                        opportunity.coverImagePath!,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: ZewgTheme.inputFill,
                        child: const Icon(
                          Icons.image_outlined,
                          size: 48,
                          color: ZewgTheme.textMuted,
                        ),
                      ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: CategoryBadge(label: opportunity.category),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Time + NEW badge
                Row(
                  children: [
                    if (isNew)
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: ZewgTheme.badgeNew,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('NEW',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700)),
                      ),
                    Text(_timeAgo(opportunity.postedAt),
                        style: const TextStyle(
                            fontSize: 12, color: ZewgTheme.textSecondary)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  opportunity.title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: ZewgTheme.textPrimary),
                ),
                const SizedBox(height: 8),
                // Tags
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    TagChip(label: opportunity.workType),
                    TagChip(label: opportunity.compensation),
                    TagChip(label: opportunity.location),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(color: ZewgTheme.border),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.business_outlined,
                        size: 16, color: ZewgTheme.textSecondary),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        opportunity.company,
                        style: const TextStyle(
                            fontSize: 13, color: ZewgTheme.textSecondary),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.visibility_outlined,
                        size: 16, color: ZewgTheme.textMuted),
                    const SizedBox(width: 4),
                    Text(_formatViews(opportunity.views),
                        style: const TextStyle(
                            fontSize: 12, color: ZewgTheme.textMuted)),
                    const SizedBox(width: 12),
                    // Edit button
                    GestureDetector(
                      onTap: onEdit,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ZewgTheme.inputFill,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.edit_outlined,
                            size: 16, color: ZewgTheme.textSecondary),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Delete button
                    GestureDetector(
                      onTap: onDelete,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF0F0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.delete_outline,
                            size: 16, color: ZewgTheme.danger),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Section Label ─────────────────────────────────────────────────────────────
class SectionLabel extends StatelessWidget {
  final String text;
  final IconData? icon;
  const SectionLabel({super.key, required this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18, color: ZewgTheme.primary),
          const SizedBox(width: 8),
        ],
        Text(text,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: ZewgTheme.textPrimary)),
      ],
    );
  }
}

// ── Form Field Label ──────────────────────────────────────────────────────────
class FieldLabel extends StatelessWidget {
  final String text;
  const FieldLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
            color: ZewgTheme.textSecondary),
      ),
    );
  }
}

// ── Zewg Dropdown ─────────────────────────────────────────────────────────────
class ZewgDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const ZewgDropdown(
      {super.key,
      required this.value,
      required this.items,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      decoration: BoxDecoration(
        color: ZewgTheme.inputFill,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down,
              color: ZewgTheme.textSecondary),
          style: const TextStyle(
              fontSize: 15, color: ZewgTheme.textPrimary, fontFamily: 'Inter'),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// ── Bottom Nav Bar ────────────────────────────────────────────────────────────
class ZewgBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const ZewgBottomNav(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ZewgTheme.surface,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, -2))
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                  icon: Icons.dashboard_outlined,
                  label: 'Dashboard',
                  selected: currentIndex == 0,
                  onTap: () => onTap(0)),
              _NavItem(
                  icon: Icons.add_circle_outline,
                  label: 'Add New',
                  selected: currentIndex == 1,
                  onTap: () => onTap(1)),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem(
      {required this.icon,
      required this.label,
      required this.selected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              color: selected ? ZewgTheme.primary : ZewgTheme.textMuted,
              size: 24),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: selected ? ZewgTheme.primary : ZewgTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
