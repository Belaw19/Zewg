import 'package:flutter/material.dart';

import 'package:zewg/core/constants/route_paths.dart';
import 'package:zewg/core/widgets/main_bottom_nav.dart';
import 'package:zewg/core/widgets/opportunity_card.dart';
import 'package:zewg/features/home/presentation/widgets/home_feed_slivers.dart';

class ZewgScholarshipsPage extends StatelessWidget {
  const ZewgScholarshipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            buildSliverHeader(context),
            buildSliverSearchAndTitle(),
            buildFilterRow(context, 'Scholarships'),
            buildSectionTitle(
              context,
              'Featured Opportunities',
              viewAllDestination: RoutePaths.homeAll,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const OpportunityCard(
                    bookmarkKey: 'scholarships_public_health',
                    title: 'Public Health Scholarship',
                    company: 'World Health Organization',
                    tags: ['Remote', 'Fully Funded', 'Global'],
                    category: 'SCHOLARSHIP',
                    categoryColor: Color(0xFFFDE2C4),
                    deadline: 'Jun 30',
                  ),
                  const SizedBox(height: 16),
                  const OpportunityCard(
                    bookmarkKey: 'scholarships_education_leader',
                    title: 'Education Leader',
                    company: 'UNESCO',
                    tags: ['Hybrid', 'Fully Funded', 'Paris, France'],
                    category: 'SCHOLARSHIP',
                    categoryColor: Color(0xFFFDE2C4),
                    deadline: 'July 1',
                  ),
                  const SizedBox(height: 16),
                  const OpportunityCard(
                    bookmarkKey: 'scholarships_social_dev',
                    title: 'Social Dev Scholar',
                    company: 'World Bank',
                    tags: ['On-site', 'Fully Funded', 'Washington, DC'],
                    category: 'SCHOLARSHIP',
                    categoryColor: Color(0xFFFDE2C4),
                    deadline: '',
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
