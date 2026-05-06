/// Core enums for the Zewg application

/// User role types in the system
enum UserRole {
  student,
  curator,
  admin;

  String get displayName {
    switch (this) {
      case UserRole.student:
        return 'Student';
      case UserRole.curator:
        return 'Curator';
      case UserRole.admin:
        return 'Admin';
    }
  }
}

/// Types of opportunities available on the platform
enum OpportunityType {
  scholarship,
  internship,
  job;

  String get displayName {
    switch (this) {
      case OpportunityType.scholarship:
        return 'Scholarship';
      case OpportunityType.internship:
        return 'Internship';
      case OpportunityType.job:
        return 'Job';
    }
  }
}

/// Status of a student's application
enum ApplicationStatus {
  draft,
  submitted,
  underReview,
  accepted,
  rejected;

  String get displayName {
    switch (this) {
      case ApplicationStatus.draft:
        return 'Draft';
      case ApplicationStatus.submitted:
        return 'Submitted';
      case ApplicationStatus.underReview:
        return 'Under Review';
      case ApplicationStatus.accepted:
        return 'Accepted';
      case ApplicationStatus.rejected:
        return 'Rejected';
    }
  }
}

/// Status of an opportunity listing
enum OpportunityStatus {
  active,
  closed,
  draft;

  String get displayName {
    switch (this) {
      case OpportunityStatus.active:
        return 'Active';
      case OpportunityStatus.closed:
        return 'Closed';
      case OpportunityStatus.draft:
        return 'Draft';
    }
  }
}
