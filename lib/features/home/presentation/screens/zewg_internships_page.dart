import 'package:flutter/material.dart';

import 'package:zewg/core/constants/route_paths.dart';
import 'package:zewg/core/widgets/main_bottom_nav.dart';
import 'package:zewg/core/widgets/opportunity_card.dart';
import 'package:zewg/features/home/presentation/widgets/home_feed_slivers.dart';

class ZewgInternshipsPage extends StatelessWidget {
  const ZewgInternshipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            buildSliverHeader(context),
            buildSliverSearchAndTitle(),
            buildFilterRow(context, 'Internships'),
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
                    bookmarkKey: 'internships_ux_intern',
                    title: 'UX Intern',
                    company: 'Google',
                    tags: ['Remote', 'Paid', 'New York'],
                    category: 'INTERNSHIP',
                    categoryColor: Color(0xFFA2F1A2),
                    deadline: 'Oct 30',
                  ),
                  const SizedBox(height: 16),
                  const OpportunityCard(
                    bookmarkKey: 'internships_social_media',
                    title: 'Social Media Intern',
                    company: 'UNICEF',
                    tags: ['Remote', 'Paid', 'Addis Ababa, Ethiopia'],
                    category: 'INTERNSHIP',
                    categoryColor: Color(0xFFA2F1A2),
                    deadline: 'Nov 15',
                  ),
                  const SizedBox(height: 16),
                  const OpportunityCard(
                    bookmarkKey: 'internships_community_outreach',
                    title: 'Community Outreach Intern',
                    company: 'Red Cross',
                    tags: ['On-site', 'Volunteer + Stipend', 'Addis Ababa, Ethiopia'],
                    category: 'INTERNSHIP',
                    categoryColor: Color(0xFFA2F1A2),
                    deadline: 'Nov 15',
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
