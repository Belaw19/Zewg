import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/opportunity_card.dart';
import '../widgets/filter_chip_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedFilter = 'All';
  int _selectedIndex = 0;
  String _searchQuery = '';
  final Set<int> _savedOpportunities = {};

  // All opportunities data
  final List<Map<String, dynamic>> _allOpportunities = [
    {
      'title': 'UX Intern',
      'organization': 'Google',
      'type': 'Internship',
      'tags': ['Remote', 'Part-Time'],
    },
    {
      'title': 'Frontend Developer (Entry-Level)',
      'organization': 'NexGen Business Co.',
      'type': 'Job',
      'tags': ['Remote', 'Full-Time'],
    },
    {
      'title': 'Public Health Scholarship',
      'organization': 'World Health Organization',
      'type': 'Scholarship',
      'tags': ['Fully-Funded'],
    },
    {
      'title': 'Network Engineer (Junior)',
      'organization': 'Cisco',
      'type': 'Job',
      'tags': ['Remote', 'Full-Time'],
    },
    {
      'title': 'Product Designer (New Grad)',
      'organization': 'Figma',
      'type': 'Job',
      'tags': ['Remote', 'Full-Time'],
    },
    {
      'title': 'Social Dev Scholar',
      'organization': 'World Bank',
      'type': 'Scholarship',
      'tags': ['Volunteer', 'Stipend'],
    },
    {
      'title': 'Community Outreach Intern',
      'organization': 'Red Cross',
      'type': 'Internship',
      'tags': ['Volunteer', 'Stipend'],
    },
    {
      'title': 'Senior UX Research Intern',
      'organization': 'DesignForGood Global',
      'type': 'Internship',
      'tags': ['Remote', 'Paid'],
    },
    {
      'title': 'Merit-Based Research Grant 2024',
      'organization': 'Ivy Research Foundation',
      'type': 'Scholarship',
      'tags': ['Grant', 'Research'],
    },
    {
      'title': 'Junior Fullstack Developer',
      'organization': 'NexGen Business Co.',
      'type': 'Job',
      'tags': ['Remote', 'Full-Time'],
    },
  ];

  List<Map<String, dynamic>> get _filteredOpportunities {
    var filtered = _allOpportunities;

    // Apply type filter
    if (_selectedFilter != 'All') {
      filtered = filtered.where((opp) => opp['type'] == _selectedFilter).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((opp) {
        final title = opp['title'].toString().toLowerCase();
        final org = opp['organization'].toString().toLowerCase();
        final query = _searchQuery.toLowerCase();
        return title.contains(query) || org.contains(query);
      }).toList();
    }

    return filtered;
  }

  void _toggleSaved(int index) {
    setState(() {
      if (_savedOpportunities.contains(index)) {
        _savedOpportunities.remove(index);
      } else {
        _savedOpportunities.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Find your future.',
          style: AppTextStyles.headlineSmall,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search jobs, internships, or keywords...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Filter Chips
          FilterChipRow(
            selectedFilter: _selectedFilter,
            onFilterSelected: (filter) {
              setState(() {
                _selectedFilter = filter;
              });
            },
          ),
          const SizedBox(height: 8),
          // Featured Opportunities Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Featured Opportunities',
                  style: AppTextStyles.titleMedium,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View all',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Opportunity List
          Expanded(
            child: _filteredOpportunities.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No opportunities found',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your filters or search',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredOpportunities.length,
                    itemBuilder: (context, index) {
                      final opportunity = _filteredOpportunities[index];
                      final globalIndex = _allOpportunities.indexOf(opportunity);
                      final isSaved = _savedOpportunities.contains(globalIndex);

                      return OpportunityCard(
                        title: opportunity['title'],
                        organization: opportunity['organization'],
                        type: opportunity['type'],
                        location: 'Remote',
                        deadline: 'Dec 31, 2026',
                        tags: List<String>.from(opportunity['tags']),
                        isSaved: isSaved,
                        onTap: () {
                          context.push('/opportunity/1');
                        },
                        onSaveToggle: () {
                          _toggleSaved(globalIndex);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 2) {
            context.push('/profile');
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            activeIcon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
