import 'dart:convert';

import 'package:zewg_admin/features/opportunities/domain/opportunity.dart';

class OpportunityMapper {
  static Opportunity fromApi(Map<String, dynamic> json, {String? payload}) {
    final extra = payload != null ? _decodePayload(payload) : <String, dynamic>{};
    final category = _displayCategory(json['category'] as String? ?? 'INTERNSHIP');
    final deadline = _parseDeadline(json['deadline']) ?? _parseDeadline(extra['deadline']);

    return Opportunity(
      id: json['id'] as String,
      title: json['title'] as String,
      category: category,
      deadline: deadline,
      workType: json['workType'] as String? ?? extra['workType'] as String? ?? 'Remote',
      compensation: json['compensation'] as String? ?? extra['compensation'] as String? ?? 'Paid',
      compensationAmount:
          json['compensationAmount'] as String? ?? extra['compensationAmount'] as String? ?? '',
      location: json['location'] as String? ?? '',
      education: json['education'] as String? ?? extra['education'] as String? ?? '',
      experience: json['experience'] as String? ?? extra['experience'] as String? ?? '',
      skills: _skillsFromJson(json['skills']) ?? _skillsFromExtra(extra),
      description: json['description'] as String? ?? '',
      applicationSteps: _stepsFromJson(json['applicationSteps']) ?? _stepsFromExtra(extra),
      applicationUrl: json['link'] as String? ?? '',
      coverImagePath: _nonEmpty(json['coverImagePath']) ?? extra['coverImagePath'] as String?,
      company: json['company'] as String? ?? '',
      views: extra['views'] as int? ?? 0,
      postedAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
    );
  }

  static Map<String, dynamic> toApi(Opportunity o) {
    return {
      'title': o.title,
      'description': o.description,
      'category': _apiCategory(o.category),
      'company': o.company,
      'deadline': o.deadline?.toIso8601String().split('T').first ?? '',
      'location': o.location,
      'type': _apiType(o.category),
      'link': o.applicationUrl,
      'workType': o.workType,
      'compensation': o.compensation,
      'compensationAmount': o.compensationAmount,
      'education': o.education,
      'experience': o.experience,
      'skills': o.skills,
      'applicationSteps': o.applicationSteps
          .map((s) => {'title': s.title, 'description': s.description})
          .toList(),
      'coverImagePath': o.coverImagePath ?? '',
    };
  }

  static String encodePayload(Opportunity o) => jsonEncode({
        'workType': o.workType,
        'compensation': o.compensation,
        'compensationAmount': o.compensationAmount,
        'education': o.education,
        'experience': o.experience,
        'skills': o.skills,
        'views': o.views,
        'deadline': o.deadline?.toIso8601String(),
        'applicationSteps': o.applicationSteps
            .map((s) => {'title': s.title, 'description': s.description})
            .toList(),
        if (o.coverImagePath != null) 'coverImagePath': o.coverImagePath,
      });

  static DateTime? _parseDeadline(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    final s = value.toString().trim();
    if (s.isEmpty) return null;
    return DateTime.tryParse(s);
  }

  static String? _nonEmpty(dynamic value) {
    final s = value?.toString().trim();
    if (s == null || s.isEmpty) return null;
    return s;
  }

  static String _displayCategory(String category) {
    switch (category.toUpperCase()) {
      case 'JOB':
        return 'Job';
      case 'SCHOLARSHIP':
        return 'Scholarship';
      default:
        return 'Internship';
    }
  }

  static String _apiCategory(String category) {
    switch (category) {
      case 'Job':
        return 'JOB';
      case 'Scholarship':
        return 'SCHOLARSHIP';
      default:
        return 'INTERNSHIP';
    }
  }

  static String _apiType(String category) {
    switch (category) {
      case 'Job':
        return 'job';
      case 'Scholarship':
        return 'scholarship';
      default:
        return 'internship';
    }
  }

  static Map<String, dynamic> _decodePayload(String raw) {
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }

  static List<String>? _skillsFromJson(dynamic raw) {
    if (raw is! List) return null;
    return raw.map((e) => e.toString()).where((s) => s.isNotEmpty).toList();
  }

  static List<String> _skillsFromExtra(Map<String, dynamic> extra) {
    final skills = extra['skills'];
    if (skills is! List) return const [];
    return skills.map((e) => e.toString()).toList();
  }

  static List<ApplicationStep>? _stepsFromJson(dynamic raw) {
    if (raw is! List) return null;
    return raw
        .map((s) => ApplicationStep(
              title: (s as Map)['title']?.toString() ?? '',
              description: s['description']?.toString() ?? '',
            ))
        .toList();
  }

  static List<ApplicationStep> _stepsFromExtra(Map<String, dynamic> extra) {
    final steps = extra['applicationSteps'];
    if (steps is! List) return const [];
    return steps
        .map((s) => ApplicationStep(
              title: (s as Map)['title']?.toString() ?? '',
              description: s['description']?.toString() ?? '',
            ))
        .toList();
  }
}
