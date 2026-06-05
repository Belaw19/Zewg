import 'package:zewg_admin/features/auth/domain/models/user_model.dart';
import 'package:zewg_admin/features/opportunities/domain/opportunity.dart';

const sampleCurator = UserModel(
  id: 'curator-1',
  name: 'Admin Curator',
  email: 'curator@zewg.com',
  role: 'curator',
  token: 'fake-token',
);

final sampleInternship = Opportunity(
  id: 'opp-1',
  title: 'Flutter Developer Intern',
  category: 'Internship',
  workType: 'Remote',
  compensation: 'Paid',
  compensationAmount: '\$25 / hr',
  location: 'Remote',
  company: 'Acme Corp',
  skills: ['Flutter', 'Dart'],
  description: 'Build mobile apps.',
  postedAt: DateTime(2025, 6, 1),
  views: 420,
);

final sampleJob = Opportunity(
  id: 'opp-2',
  title: 'Backend Engineer',
  category: 'Job',
  workType: 'On-site',
  compensation: 'Paid',
  location: 'Addis Ababa',
  company: 'Beta Inc',
  postedAt: DateTime(2025, 5, 15),
  views: 1200,
);

final sampleScholarship = Opportunity(
  id: 'opp-3',
  title: 'STEM Scholarship',
  category: 'Scholarship',
  workType: 'Remote',
  compensation: 'Paid',
  compensationAmount: 'Fully Funded',
  location: 'Global',
  company: 'Edu Foundation',
  postedAt: DateTime(2025, 4, 1),
  views: 800,
);

List<Opportunity> get testOpportunities => [
      sampleInternship,
      sampleJob,
      sampleScholarship,
    ];
