class ApplicationStep {
  String title;
  String description;

  ApplicationStep({required this.title, required this.description});

  ApplicationStep copyWith({String? title, String? description}) {
    return ApplicationStep(
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}

class Opportunity {
  final String id;
  String title;
  String category; // Job, Internship, Scholarship
  DateTime? deadline;
  String workType; // Remote, On-site, Hybrid
  String compensation; // Paid, Unpaid, Stipend
  String compensationAmount;
  String location;
  String education;
  String experience;
  List<String> skills;
  String description;
  List<ApplicationStep> applicationSteps;
  String applicationUrl;
  String? coverImagePath;
  String company;
  int views;
  bool isPendingApproval;
  DateTime postedAt;

  Opportunity({
    required this.id,
    required this.title,
    required this.category,
    this.deadline,
    required this.workType,
    required this.compensation,
    this.compensationAmount = '',
    required this.location,
    this.education = '',
    this.experience = '',
    this.skills = const [],
    this.description = '',
    this.applicationSteps = const [],
    this.applicationUrl = '',
    this.coverImagePath,
    required this.company,
    this.views = 0,
    this.isPendingApproval = false,
    required this.postedAt,
  });
}

// Sample data
List<Opportunity> sampleOpportunities = [
  Opportunity(
    id: '1',
    title: 'Senior UX Research Intern',
    coverImagePath: 'assets/images/3.jpg',
    category: 'Internship',
    deadline: DateTime(2023, 10, 24),
    workType: 'Remote',
    compensation: 'Paid',
    compensationAmount: '\$45 - \$55 / hr',
    location: 'San Francisco, CA',
    education:
        "Master's or PhD candidate in HCI, Psychology, Anthropology, or a related social science",
    experience:
        '1+ years of industry experience conducting end-to-end qualitative research studies in a',
    skills: ['Figma', 'Dovetail', 'UserTesting', 'Qualitative Coding'],
    description:
        'As a Senior UX Research Intern, you will be embedded within our Core Experience team. You will lead high-impact research projects that influence the product roadmap for the upcoming academic year.\n\nKey Responsibilities:\n- Design and execute qualitative research studies, including semi-structured interviews, diary studies, and usability testing.',
    applicationSteps: [
      ApplicationStep(
          title: 'Portfolio Review',
          description:
              'Initial screening of past research artifacts and methodologies.'),
      ApplicationStep(
          title: 'Technical Interview',
          description:
              '60-minute session focusing on study design and analytical depth.'),
      ApplicationStep(
          title: 'Executive Sync',
          description:
              'Final culture-fit and strategic alignment with the Head of Research.'),
    ],
    applicationUrl: 'https://careers.zewg.edu/apply',
    company: 'DesignSphere Global',
    views: 1200,
    postedAt: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  Opportunity(
    id: '2',
    title: 'Merit-Based Research Grant 2024',
    coverImagePath: 'assets/images/1.jpg',
    category: 'Scholarship',
    deadline: DateTime(2024, 3, 15),
    workType: 'Remote',
    compensation: 'Paid',
    compensationAmount: 'Fully Funded',
    location: 'Global',
    education: "Open to graduate students in any research discipline",
    experience: 'Prior research publication preferred',
    skills: ['Research', 'Academic Writing'],
    description: 'Merit-based grant for outstanding graduate researchers.',
    applicationSteps: [
      ApplicationStep(
          title: 'Submit Proposal',
          description: 'Submit a 5-page research proposal.'),
      ApplicationStep(
          title: 'Committee Review',
          description: 'Panel review of submitted proposals.'),
    ],
    applicationUrl: 'https://grants.zewg.edu/apply',
    company: 'Ivy Academic Foundation',
    views: 4800,
    postedAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Opportunity(
    id: '3',
    title: 'Junior Fullstack Developer',
    coverImagePath: 'assets/images/2.jpg',
    category: 'Job',
    deadline: DateTime(2024, 2, 28),
    workType: 'On-site',
    compensation: 'Paid',
    compensationAmount: '\$80k - \$100k',
    location: 'Berlin, Germany',
    education: "BS in Computer Science or equivalent",
    experience: '1-2 years of fullstack development experience',
    skills: ['React', 'Node.js', 'PostgreSQL'],
    description: 'Join our growing engineering team in Berlin.',
    applicationSteps: [
      ApplicationStep(
          title: 'Submit Portfolio',
          description: 'Submit GitHub profile and portfolio.'),
      ApplicationStep(
          title: 'Technical Test', description: 'Take-home coding challenge.'),
    ],
    applicationUrl: 'https://jobs.nexgen.com/apply',
    company: 'NexGen Systems Ltd.',
    views: 2400,
    postedAt: DateTime.now().subtract(const Duration(days: 3)),
  ),
];
