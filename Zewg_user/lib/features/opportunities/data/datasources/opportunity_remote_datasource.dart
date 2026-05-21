import 'package:zewg/features/opportunities/domain/models/opportunity.dart';

/// Simulates a remote opportunities API.
class OpportunityRemoteDataSource {
  static final List<Opportunity> _seed = [
    const Opportunity(
      id: '1',
      title: 'UX Intern',
      company: 'Google',
      category: 'INTERNSHIP',
      location: 'New York',
      deadline: 'Oct 30',
      description:
          'Join Google\'s UX team as an intern and work on real products used by billions of people. You will collaborate with designers, researchers, and engineers.',
      link: 'https://careers.google.com',
      tags: ['Remote', 'Paid', 'New York'],
    ),
    const Opportunity(
      id: '2',
      title: 'Social Media Intern',
      company: 'UNICEF',
      category: 'INTERNSHIP',
      location: 'Addis Ababa, Ethiopia',
      deadline: 'Nov 15',
      description:
          'Support UNICEF\'s communications team by creating engaging social media content that raises awareness for children\'s rights globally.',
      link: 'https://www.unicef.org/careers',
      tags: ['Remote', 'Paid', 'Addis Ababa, Ethiopia'],
    ),
    const Opportunity(
      id: '3',
      title: 'Community Outreach Intern',
      company: 'Red Cross',
      category: 'INTERNSHIP',
      location: 'Addis Ababa, Ethiopia',
      deadline: 'Nov 15',
      description:
          'Help coordinate community outreach programs and disaster relief efforts across Ethiopia.',
      link: 'https://www.redcross.org/careers',
      tags: ['On-site', 'Volunteer + Stipend', 'Addis Ababa, Ethiopia'],
    ),
    const Opportunity(
      id: '4',
      title: 'Public Health Scholarship',
      company: 'World Health Organization',
      category: 'SCHOLARSHIP',
      location: 'Global',
      deadline: 'Nov 15',
      description:
          'The WHO Public Health Scholarship supports students pursuing graduate studies in public health, epidemiology, or global health policy.',
      link: 'https://www.who.int/scholarships',
      tags: ['Remote', 'Fully Funded', 'Global'],
    ),
    const Opportunity(
      id: '5',
      title: 'Education Leader',
      company: 'UNESCO',
      category: 'SCHOLARSHIP',
      location: 'Paris, France',
      deadline: 'July 1',
      description:
          'UNESCO\'s Education Leader program funds exceptional students committed to transforming education systems in developing countries.',
      link: 'https://en.unesco.org/fellowships',
      tags: ['Hybrid', 'Fully Funded', 'Paris, France'],
    ),
    const Opportunity(
      id: '6',
      title: 'Social Dev Scholar',
      company: 'World Bank',
      category: 'SCHOLARSHIP',
      location: 'Washington, DC',
      deadline: 'Jun 30',
      description:
          'The World Bank Social Development Scholarship supports students from developing countries studying social policy and development economics.',
      link: 'https://www.worldbank.org/scholarships',
      tags: ['On-site', 'Fully Funded', 'Washington, DC'],
    ),
    const Opportunity(
      id: '7',
      title: 'Product Designer (New Grad)',
      company: 'Figma',
      category: 'JOB',
      location: 'San Francisco, CA',
      deadline: 'Oct 25',
      description:
          'Figma is looking for a new-grad product designer to join our growing design team. You will shape the future of collaborative design tools.',
      link: 'https://www.figma.com/careers',
      tags: ['Remote', '\$110k – \$140k', 'San Francisco, CA'],
    ),
    const Opportunity(
      id: '8',
      title: 'Frontend Developer (Entry Level)',
      company: 'Google',
      category: 'JOB',
      location: 'New York, NY',
      deadline: 'Nov 10',
      description:
          'Build and maintain high-quality web applications at Google. You will work with modern JavaScript frameworks and collaborate with world-class engineers.',
      link: 'https://careers.google.com',
      tags: ['Remote', '\$90k – \$120k', 'New York, NY'],
    ),
    const Opportunity(
      id: '9',
      title: 'Network Engineer (Junior)',
      company: 'Cisco',
      category: 'JOB',
      location: 'San Jose, CA',
      deadline: 'Nov 15',
      description:
          'Join Cisco\'s networking team to design, implement, and maintain enterprise network infrastructure for global clients.',
      link: 'https://jobs.cisco.com',
      tags: ['Remote', '\$80k – \$105k', 'San Jose, CA'],
    ),
    const Opportunity(
      id: '10',
      title: 'Future Tech Innovators Fellowship',
      company: 'Global Innovation Lab',
      category: 'SCHOLARSHIP',
      location: 'Remote / San Francisco',
      deadline: 'Oct 24',
      description:
          'The Future Tech Innovators Fellowship is designed for undergraduate students pushing the boundaries of AI and sustainable technology. Fellows receive a \$15,000 research stipend and mentorship from industry pioneers.',
      link: 'https://opportunity.com/apply',
      tags: ['Remote', 'Fully Funded', 'San Francisco'],
    ),
    const Opportunity(
      id: '11',
      title: 'Global Leadership Program',
      company: 'University of Oxford',
      category: 'SCHOLARSHIP',
      location: 'Oxford, UK',
      deadline: 'Dec 1',
      description:
          'Oxford\'s Global Leadership Program selects outstanding students from around the world for a transformative leadership development experience.',
      link: 'https://www.ox.ac.uk/scholarships',
      tags: ['On-site', 'Fully Funded', 'Oxford, UK'],
    ),
    const Opportunity(
      id: '12',
      title: 'UX Design Research Intern',
      company: 'Design Curators Ltd.',
      category: 'INTERNSHIP',
      location: 'Remote',
      deadline: 'Nov 20',
      description:
          'Conduct user research and usability testing to inform product design decisions at Design Curators Ltd.',
      link: 'https://designcurators.com/careers',
      tags: ['Remote', 'Paid', 'Remote'],
    ),
  ];

  Future<List<Opportunity>> fetchAll() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.unmodifiable(_seed);
  }

  Future<Opportunity> fetchById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _seed.firstWhere((o) => o.id == id, orElse: () => throw Exception('Not found'));
  }
}
