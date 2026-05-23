class Opportunity {
  final String id;
  final String title;
  final String company;
  final String category; // 'JOB' | 'INTERNSHIP' | 'SCHOLARSHIP'
  final String location;
  final String deadline;
  final String description;
  final String link;
  final String type; // job | internship | scholarship
  final String createdBy;
  final String createdAt;
  final List<String> tags;
  final String coverImagePath;
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
    required this.type,
    required this.createdBy,
    required this.createdAt,
    this.tags = const [],
    this.coverImagePath = '',
    this.isSaved = false,
    this.isApplied = false,
  });

  Opportunity copyWith({
    bool? isSaved,
    bool? isApplied,
    String? title,
    String? description,
    String? company,
    String? category,
    String? location,
    String? deadline,
    String? link,
    String? type,
  }) =>
      Opportunity(
        id: id,
        title: title ?? this.title,
        company: company ?? this.company,
        category: category ?? this.category,
        location: location ?? this.location,
        deadline: deadline ?? this.deadline,
        description: description ?? this.description,
        link: link ?? this.link,
        type: type ?? this.type,
        createdBy: createdBy,
        createdAt: createdAt,
      tags: tags,
      coverImagePath: this.coverImagePath,
      isSaved: isSaved ?? this.isSaved,
      isApplied: isApplied ?? this.isApplied,
      );

  factory Opportunity.fromMap(Map<String, dynamic> m) {
    final rawTags = m['tags'];
    final List<String> parsedTags = rawTags is List
        ? rawTags.map((e) => e.toString()).toList()
        : rawTags is String && rawTags.isNotEmpty
            ? (rawTags.startsWith('[')
                ? <String>[]
                : rawTags.split(',').where((t) => t.isNotEmpty).toList())
            : <String>[];

    bool parseBool(dynamic v) {
      if (v is bool) return v;
      if (v is int) return v == 1;
      return false;
    }

    final category = (m['category'] as String?) ?? _categoryFromType(m['type'] as String? ?? 'internship');

    return Opportunity(
      id: m['id'] as String,
      title: m['title'] as String,
      company: m['company'] as String,
      category: category,
      location: m['location'] as String? ?? '',
      deadline: m['deadline'] as String? ?? '',
      description: m['description'] as String? ?? '',
      link: m['link'] as String? ?? '',
      type: (m['type'] as String?) ?? _typeFromCategory(category),
      createdBy: m['created_by'] as String? ?? m['createdBy'] as String? ?? '',
      createdAt: m['created_at'] as String? ?? m['createdAt'] as String? ?? '',
      tags: parsedTags,
      coverImagePath: _stringOrEmpty(m['cover_image_path'] ?? m['coverImagePath']),
      isSaved: parseBool(m['is_saved']),
      isApplied: parseBool(m['is_applied']),
    );
  }

  factory Opportunity.fromApi(Map<String, dynamic> json) {
    final category = json['category'] as String? ?? 'INTERNSHIP';
    return Opportunity(
      id: json['id'] as String,
      title: json['title'] as String,
      company: json['company'] as String,
      category: category,
      location: json['location'] as String? ?? '',
      deadline: json['deadline'] as String? ?? '',
      description: json['description'] as String? ?? '',
      link: json['link'] as String? ?? '',
      type: json['type'] as String? ?? _typeFromCategory(category),
      createdBy: json['createdBy'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      tags: _defaultTags(json),
      coverImagePath: _stringOrEmpty(json['coverImagePath'] ?? json['cover_image_path']),
    );
  }

  /// Handles null/missing values from API or old SQLite rows.
  static String _stringOrEmpty(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    return value.toString();
  }

  static List<String> _defaultTags(Map<String, dynamic> json) {
    final tags = <String>[];
    final workType = json['workType'] as String?;
    final compensation = json['compensation'] as String?;
    final compensationAmount = json['compensationAmount'] as String?;
    final location = json['location'] as String? ?? '';

    if (workType != null && workType.isNotEmpty) tags.add(workType);
    if (compensation != null && compensation.isNotEmpty) tags.add(compensation);
    if (compensationAmount != null && compensationAmount.isNotEmpty) {
      tags.add(compensationAmount);
    }
    if (location.isNotEmpty) tags.add(location);

    final skills = json['skills'];
    if (skills is List) {
      tags.addAll(skills.map((e) => e.toString()).where((s) => s.isNotEmpty));
    }

    if (tags.isEmpty) {
      final type = json['type'] as String? ?? '';
      if (type.isNotEmpty) tags.add(type);
    }
    return tags;
  }

  static String _typeFromCategory(String category) {
    switch (category.toUpperCase()) {
      case 'JOB':
      case 'JOBS':
        return 'job';
      case 'SCHOLARSHIP':
      case 'SCHOLARSHIPS':
        return 'scholarship';
      default:
        return 'internship';
    }
  }

  static String _categoryFromType(String type) {
    switch (type) {
      case 'job':
        return 'JOB';
      case 'scholarship':
        return 'SCHOLARSHIP';
      default:
        return 'INTERNSHIP';
    }
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
        'type': type,
        'created_by': createdBy,
        'created_at': createdAt,
        'tags': tags,
        'cover_image_path': coverImagePath,
        'is_saved': isSaved ? 1 : 0,
        'is_applied': isApplied ? 1 : 0,
      };

  Map<String, dynamic> toApiBody() => {
        'title': title,
        'description': description,
        'category': category,
        'company': company,
        'deadline': deadline,
        'location': location,
        'type': type,
        'link': link,
      };
}
