import 'package:flutter/material.dart';

import 'package:zewg/core/widgets/main_bottom_nav.dart';
import 'package:zewg/core/widgets/opportunity_card.dart';
import 'package:zewg/features/home/presentation/widgets/home_feed_slivers.dart';

class ZewgHomePage extends StatelessWidget {
  const ZewgHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            buildSliverHeader(context),
            buildSliverSearchAndTitle(),
            buildFilterRow(context, 'All'),
            buildSectionTitle(context, 'Featured Opportunities'),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const OpportunityCard(
                    bookmarkKey: 'home_ux_intern',
                    title: 'UX Intern',
                    company: 'Google',
                    tags: ['Remote', 'Paid', 'New York'],
                    category: 'INTERNSHIP',
                    categoryColor: Color(0xFFA2F1A2),
                    deadline: 'Oct 30',
                  ),
                  const SizedBox(height: 16),
                  const OpportunityCard(
                    bookmarkKey: 'home_public_health',
                    title: 'Public Health Scholarship',
                    company: 'World Health Organization',
                    tags: ['Remote', 'Fully Funded', 'Global'],
                    category: 'SCHOLARSHIP',
                    categoryColor: Color(0xFFFDE2C4),
                    deadline: 'Nov 15',
                  ),
                  const SizedBox(height: 16),
                  const OpportunityCard(
                    bookmarkKey: 'home_product_designer',
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
