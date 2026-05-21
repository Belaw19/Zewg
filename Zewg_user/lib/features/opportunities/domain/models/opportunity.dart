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

  Opportunity copyWith({bool? isSaved, bool? isApplied}) => Opportunity(
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

  factory Opportunity.fromMap(Map<String, dynamic> m) {
    // tags can be a List (from JSON) or a comma-string (legacy)
    final rawTags = m['tags'];
    final List<String> parsedTags = rawTags is List
        ? rawTags.map((e) => e.toString()).toList()
        : (rawTags as String).split(',').where((t) => t.isNotEmpty).toList();

    // isSaved / isApplied can be bool (from JSON) or int (legacy SQLite)
    bool parseBool(dynamic v) {
      if (v is bool) return v;
      if (v is int) return v == 1;
      return false;
    }

    return Opportunity(
      id: m['id'] as String,
      title: m['title'] as String,
      company: m['company'] as String,
      category: m['category'] as String,
      location: m['location'] as String,
      deadline: m['deadline'] as String,
      description: m['description'] as String,
      link: m['link'] as String,
      tags: parsedTags,
      isSaved: parseBool(m['is_saved']),
      isApplied: parseBool(m['is_applied']),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'company': company,
        'category': category,
        'location': location,
        'deadline': deadline,
        'description': description,
        'link': link,
        'tags': tags, // store as List — JSON-safe
        'is_saved': isSaved,
        'is_applied': isApplied,
      };
}
