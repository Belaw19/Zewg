import 'package:zewg/features/auth/domain/models/user_model.dart';
import 'package:zewg/features/opportunities/domain/models/opportunity.dart';

const sampleUser = UserModel(
  id: 'user-1',
  name: 'Test User',
  email: 'test@zewg.com',
  role: 'student',
  token: 'fake-token',
);

final sampleInternship = Opportunity(
  id: 'opp-1',
  title: 'Flutter Developer Intern',
  company: 'Acme Corp',
  category: 'INTERNSHIP',
  location: 'Remote',
  deadline: '2026-12-31',
  description: 'Build mobile apps with Flutter.',
  link: 'https://example.com/apply',
  type: 'internship',
  createdBy: 'curator-1',
  createdAt: '2026-01-15',
  tags: ['Flutter', 'Remote'],
);

final sampleJob = Opportunity(
  id: 'opp-2',
  title: 'Backend Engineer',
  company: 'Beta Inc',
  category: 'JOB',
  location: 'Addis Ababa',
  deadline: '2026-06-30',
  description: 'API development role.',
  link: 'https://example.com/jobs',
  type: 'job',
  createdBy: 'curator-1',
  createdAt: '2026-02-01',
  tags: ['Node.js'],
);

final sampleScholarship = Opportunity(
  id: 'opp-3',
  title: 'STEM Scholarship',
  company: 'Edu Foundation',
  category: 'SCHOLARSHIP',
  location: 'Global',
  deadline: '2026-03-15',
  description: 'Full tuition support.',
  link: 'https://example.com/scholarship',
  type: 'scholarship',
  createdBy: 'curator-2',
  createdAt: '2026-02-10',
);

List<Opportunity> get sampleOpportunities => [
      sampleInternship,
      sampleJob,
      sampleScholarship,
    ];

Map<String, dynamic> sampleOpportunityMap() => {
      'id': 'map-1',
      'title': 'Data Analyst',
      'company': 'Gamma LLC',
      'category': 'JOB',
      'location': 'Remote',
      'deadline': '2026-08-01',
      'description': 'Analyze datasets.',
      'link': 'https://example.com',
      'type': 'job',
      'created_by': 'curator-1',
      'created_at': '2026-03-01',
      'tags': ['SQL', 'Python'],
      'is_saved': 1,
      'is_applied': 0,
    };
