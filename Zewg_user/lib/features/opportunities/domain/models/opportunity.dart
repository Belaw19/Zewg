class Opportunity {
  final String id;
  final String title;
  final String company;
  final String category; // 'JOB' | 'INTERNSHIP' | 'SCHOLARSHIP'
  final String location;
  final String deadline;
  final String description;
  final String link;
  final List<String> tags;
  final bool isSaved;
  final bool isApplied;

  const Opportunity({
    required this.id,
    required this.title,
    required this.company,
    required this.category,
    required this.location,
    required this.deadline,
    required this.description,
    required this.link,
    required this.tags,
    this.isSaved = false,
    this.isApplied = false,
  });

  Opportunity copyWith({
    bool? isSaved,
    bool? isApplied,
  }) =>
      Opportunity(
        id: id,
        title: title,
        company: company,
        category: category,
        location: location,
        deadline: deadline,
        description: description,
        link: link,
        tags: tags,
        isSaved: isSaved ?? this.isSaved,
        isApplied: isApplied ?? this.isApplied,
      );

  factory Opportunity.fromMap(Map<String, dynamic> m) => Opportunity(
        id: m['id'] as String,
        title: m['title'] as String,
        company: m['company'] as String,
        category: m['category'] as String,
        location: m['location'] as String,
        deadline: m['deadline'] as String,
        description: m['description'] as String,
        link: m['link'] as String,
        tags: (m['tags'] as String).split(',').where((t) => t.isNotEmpty).toList(),
        isSaved: (m['is_saved'] as int? ?? 0) == 1,
        isApplied: (m['is_applied'] as int? ?? 0) == 1,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'company': company,
        'category': category,
        'location': location,
        'deadline': deadline,
        'description': description,
        'link': link,
        'tags': tags.join(','),
        'is_saved': isSaved ? 1 : 0,
        'is_applied': isApplied ? 1 : 0,
      };
}
