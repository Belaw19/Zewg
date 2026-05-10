import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:zewg/core/constants/route_paths.dart';

class CuratorDashboardPage extends StatelessWidget {
  const CuratorDashboardPage({super.key});

  static const _opportunities = [
    _OpportunityItem(
      title: 'UX Design Research Intern',
      org: 'Design Curators Ltd.',
      type: 'INTERNSHIP',
      typeColor: Color(0xFFA2F1A2),
      typeTextColor: Color(0xFF1A5C1A),
      status: 'PUBLISHED',
      statusColor: Color(0xFFD1FAE5),
      statusTextColor: Color(0xFF065F46),
      deadline: 'Nov 15',
    ),
    _OpportunityItem(
      title: 'Frontend Developer (Entry Level)',
      org: 'TechBridge Africa',
      type: 'JOB',
      typeColor: Color(0xFFD4E5EF),
      typeTextColor: Color(0xFF1A3A5C),
      status: 'DRAFT',
      statusColor: Color(0xFFF3F4F6),
      statusTextColor: Color(0xFF6B7280),
      deadline: 'Dec 1',
    ),
    _OpportunityItem(
      title: 'Global Leadership Scholarship',
      org: 'African Union Commission',
      type: 'SCHOLARSHIP',
      typeColor: Color(0xFFFDE2C4),
      typeTextColor: Color(0xFF7A3B00),
      status: 'PUBLISHED',
      statusColor: Color(0xFFD1FAE5),
      statusTextColor: Color(0xFF065F46),
      deadline: 'Jan 10',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Zewg',
          style: TextStyle(color: Color(0xFF004D61), fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () => context.go(RoutePaths.signIn),
              behavior: HitTestBehavior.opaque,
              child: const CircleAvatar(
                backgroundColor: Color(0xFF004D61),
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Curator Dashboard',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Color(0xFF1A1A1A)),
            ),
            const SizedBox(height: 6),
            const Text(
              'Manage and publish opportunities for students.',
              style: TextStyle(fontSize: 15, color: Color(0xFF555555)),
            ),
            const SizedBox(height: 24),

            // Stats row
            Row(
              children: [
                _buildStatCard('3', 'TOTAL', Icons.list_alt_outlined),
                const SizedBox(width: 14),
                _buildStatCard('2', 'PUBLISHED', Icons.check_circle_outline),
                const SizedBox(width: 14),
                _buildStatCard('1', 'DRAFT', Icons.edit_outlined),
              ],
            ),

            const SizedBox(height: 28),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Opportunities',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
                ),
                GestureDetector(
                  onTap: () => context.go(RoutePaths.curatorAdd),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF004D61),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.add, color: Colors.white, size: 18),
                        SizedBox(width: 6),
                        Text('Add New', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            ..._opportunities.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _buildOpportunityCard(context, item),
            )),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF004D61), size: 22),
            const SizedBox(height: 10),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
            Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF888888), letterSpacing: 0.8)),
          ],
        ),
      ),
    );
  }

  Widget _buildOpportunityCard(BuildContext context, _OpportunityItem item) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(item.org, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: item.statusColor, borderRadius: BorderRadius.circular(20)),
                child: Text(item.status, style: TextStyle(color: item.statusTextColor, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: item.typeColor, borderRadius: BorderRadius.circular(6)),
                child: Text(item.type, style: TextStyle(color: item.typeTextColor, fontSize: 10, fontWeight: FontWeight.w800)),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.calendar_today_outlined, size: 13, color: Colors.grey),
              const SizedBox(width: 4),
              Text('Deadline: ${item.deadline}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const Spacer(),
              GestureDetector(
                onTap: () => context.go(RoutePaths.curatorEdit),
                behavior: HitTestBehavior.opaque,
                child: const Icon(Icons.edit_outlined, color: Color(0xFF004D61), size: 20),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}

class _OpportunityItem {
  final String title;
  final String org;
  final String type;
  final Color typeColor;
  final Color typeTextColor;
  final String status;
  final Color statusColor;
  final Color statusTextColor;
  final String deadline;

  const _OpportunityItem({
    required this.title,
    required this.org,
    required this.type,
    required this.typeColor,
    required this.typeTextColor,
    required this.status,
    required this.statusColor,
    required this.statusTextColor,
    required this.deadline,
  });
}
