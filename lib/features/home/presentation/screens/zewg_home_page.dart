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
            buildSectionTitle('Featured Opportunities'),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Internships
                  const OpportunityCard(
                    title: 'UX Intern',
                    company: 'Google',
                    tags: ['Remote', 'Paid', 'New York'],
                    category: 'INTERNSHIP',
                    categoryColor: Color(0xFFA2F1A2),
                    deadline: 'Oct 30',
                  ),
                  const SizedBox(height: 16),
                  const OpportunityCard(
                    title: 'Social Media Intern',
                    company: 'UNICEF',
                    tags: ['Remote', 'Paid', 'Addis Ababa, Ethiopia'],
                    category: 'INTERNSHIP',
                    categoryColor: Color(0xFFA2F1A2),
                    deadline: 'Nov 15',
                  ),
                  const SizedBox(height: 16),
                  const OpportunityCard(
                    title: 'Community Outreach Intern',
                    company: 'Red Cross',
                    tags: ['On-site', 'Volunteer + Stipend', 'Addis Ababa, Ethiopia'],
                    category: 'INTERNSHIP',
                    categoryColor: Color(0xFFA2F1A2),
                    deadline: 'Nov 15',
                  ),
                  const SizedBox(height: 16),
                  // Scholarships
                  const OpportunityCard(
                    title: 'Public Health Scholarship',
                    company: 'World Health Organization',
                    tags: ['Remote', 'Fully Funded', 'Global'],
                    category: 'SCHOLARSHIP',
                    categoryColor: Color(0xFFFDE2C4),
                    deadline: 'Nov 15',
                  ),
                  const SizedBox(height: 16),
                  const OpportunityCard(
                    title: 'Education Leader',
                    company: 'UNESCO',
                    tags: ['Hybrid', 'Fully Funded', 'Paris, France'],
                    category: 'SCHOLARSHIP',
                    categoryColor: Color(0xFFFDE2C4),
                    deadline: 'July 1',
                  ),
                  const SizedBox(height: 16),
                  const OpportunityCard(
                    title: 'Social Dev Scholar',
                    company: 'World Bank',
                    tags: ['On-site', 'Fully Funded', 'Washington, DC'],
                    category: 'SCHOLARSHIP',
                    categoryColor: Color(0xFFFDE2C4),
                    deadline: 'Jun 30',
                  ),
                  const SizedBox(height: 16),
                  // Jobs
                  const OpportunityCard(
                    title: 'Product Designer (New Grad)',
                    company: 'Figma',
                    tags: ['Remote', '\$110k – \$140k', 'San Francisco, CA'],
                    category: 'JOB',
                    categoryColor: Color(0xFFD4E5EF),
                    deadline: 'Oct 25',
                  ),
                  const SizedBox(height: 16),
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
