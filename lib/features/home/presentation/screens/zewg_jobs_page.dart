import 'package:flutter/material.dart';

import 'package:zewg/core/widgets/main_bottom_nav.dart';
import 'package:zewg/core/widgets/opportunity_card.dart';
import 'package:zewg/features/home/presentation/widgets/home_feed_slivers.dart';

class ZewgJobsPage extends StatelessWidget {
  const ZewgJobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            buildSliverHeader(context),
            buildSliverSearchAndTitle(),
            buildFilterRow(context, 'Jobs'),
            buildSectionTitle('Featured Opportunities'),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const OpportunityCard(
                    title: 'Frontend Developer (Entry Level)',
                    company: 'Google',
                    tags: ['Remote', '\$90k – \$120k', 'New York, NY'],
                    category: 'JOB',
                    categoryColor: Color(0xFFD4E5EF),
                    deadline: 'Nov 10',
                  ),
                  const SizedBox(height: 16),
                  const OpportunityCard(
                    title: 'Network Engineer (Junior)',
                    company: 'Cisco',
                    tags: ['Remote', '\$80k – \$105k', 'San Jose, CA'],
                    category: 'JOB',
                    categoryColor: Color(0xFFD4E5EF),
                    deadline: 'Nov 15',
                  ),
                  const SizedBox(height: 16),
                  const OpportunityCard(
                    title: 'Product Designer (New Grad)',
                    company: 'Figma',
                    tags: ['Remote', '\$110k – \$140k', 'San Francisco, CA'],
                    category: 'JOB',
                    categoryColor: Color(0xFFD4E5EF),
                    deadline: 'Oct 25',
                  ),
                  const SizedBox(height: 100),
                ]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildMainBottomNav(context, isHome: true),
    );
  }
}
