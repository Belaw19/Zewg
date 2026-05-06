import 'package:intl/intl.dart';

/// Date formatting and parsing utilities
class DateFormatter {
  // Private constructor to prevent instantiation
  DateFormatter._();

  // Date format patterns
  static const String _defaultDateFormat = 'MMM dd, yyyy';
  static const String _shortDateFormat = 'MM/dd/yyyy';
  static const String _longDateFormat = 'MMMM dd, yyyy';
  static const String _timeFormat = 'hh:mm a';
  static const String _dateTimeFormat = 'MMM dd, yyyy hh:mm a';
  static const String _isoFormat = 'yyyy-MM-dd';

  /// Formats a DateTime to default format (e.g., "Jan 15, 2024")
  static String formatDate(DateTime date) {
    return DateFormat(_defaultDateFormat).format(date);
  }

  /// Formats a DateTime to short format (e.g., "01/15/2024")
  static String formatShortDate(DateTime date) {
    return DateFormat(_shortDateFormat).format(date);
  }

  /// Formats a DateTime to long format (e.g., "January 15, 2024")
  static String formatLongDate(DateTime date) {
    return DateFormat(_longDateFormat).format(date);
  }

  /// Formats a DateTime to time only (e.g., "03:30 PM")
  static String formatTime(DateTime date) {
    return DateFormat(_timeFormat).format(date);
  }

  /// Formats a DateTime to date and time (e.g., "Jan 15, 2024 03:30 PM")
  static String formatDateTime(DateTime date) {
    return DateFormat(_dateTimeFormat).format(date);
  }

  /// Formats a DateTime to ISO 8601 date format (e.g., "2024-01-15")
  static String formatIsoDate(DateTime date) {
    return DateFormat(_isoFormat).format(date);
  }

  /// Formats a DateTime to ISO 8601 date-time format (e.g., "2024-01-15T15:30:00.000Z")
  static String formatIsoDateTime(DateTime date) {
    return date.toUtc().toIso8601String();
  }

  /// Formats a DateTime with a custom pattern
  static String formatCustom(DateTime date, String pattern) {
    return DateFormat(pattern).format(date);
  }

  /// Parses a date string to DateTime
  static DateTime? parseDate(String dateString, {String? format}) {
    try {
      if (format != null) {
        return DateFormat(format).parse(dateString);
      }
      // Try common formats
      return DateTime.tryParse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Parses an ISO 8601 date string to DateTime
  static DateTime? parseIsoDate(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Returns a relative time string (e.g., "2 hours ago", "in 3 days")
  static String relativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.isNegative) {
      // Future date
      final futureDiff = date.difference(now);
      if (futureDiff.inDays > 365) {
        final years = (futureDiff.inDays / 365).floor();
        return 'in ${years} ${years == 1 ? 'year' : 'years'}';
      } else if (futureDiff.inDays > 30) {
        final months = (futureDiff.inDays / 30).floor();
        return 'in ${months} ${months == 1 ? 'month' : 'months'}';
      } else if (futureDiff.inDays > 0) {
        return 'in ${futureDiff.inDays} ${futureDiff.inDays == 1 ? 'day' : 'days'}';
      } else if (futureDiff.inHours > 0) {
        return 'in ${futureDiff.inHours} ${futureDiff.inHours == 1 ? 'hour' : 'hours'}';
      } else if (futureDiff.inMinutes > 0) {
        return 'in ${futureDiff.inMinutes} ${futureDiff.inMinutes == 1 ? 'minute' : 'minutes'}';
      } else {
        return 'in a few seconds';
      }
    } else {
      // Past date
      if (difference.inDays > 365) {
        final years = (difference.inDays / 365).floor();
        return '${years} ${years == 1 ? 'year' : 'years'} ago';
      } else if (difference.inDays > 30) {
        final months = (difference.inDays / 30).floor();
        return '${months} ${months == 1 ? 'month' : 'months'} ago';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
      } else {
        return 'just now';
      }
    }
  }

  /// Returns a short relative time string (e.g., "2h", "3d")
  static String shortRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).abs();

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}y';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}mo';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }

  /// Returns time remaining until a deadline (e.g., "2 days left", "Expired")
  static String timeRemaining(DateTime deadline) {
    final now = DateTime.now();
    final difference = deadline.difference(now);

    if (difference.isNegative) {
      return 'Expired';
    }

    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} left';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} left';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} left';
    } else {
      return 'Expires soon';
    }
  }

  /// Checks if a date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Checks if a date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  /// Checks if a date is tomorrow
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  /// Returns a friendly date string (e.g., "Today", "Yesterday", "Jan 15")
  static String friendlyDate(DateTime date) {
    if (isToday(date)) {
      return 'Today';
    } else if (isYesterday(date)) {
      return 'Yesterday';
    } else if (isTomorrow(date)) {
      return 'Tomorrow';
    } else if (DateTime.now().difference(date).inDays < 7) {
      return DateFormat('EEEE').format(date); // Day of week
    } else {
      return formatDate(date);
    }
  }

  /// Returns the start of day for a given date
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Returns the end of day for a given date
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  /// Returns the start of month for a given date
  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Returns the end of month for a given date
  static DateTime endOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0, 23, 59, 59, 999);
  }

  /// Calculates age from a birth date
  static int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}
