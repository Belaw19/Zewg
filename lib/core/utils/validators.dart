/// Input validation utilities for form fields
class Validators {
  // Private constructor to prevent instantiation
  Validators._();

  /// Email validation regex pattern
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  /// URL validation regex pattern
  static final RegExp _urlRegex = RegExp(
    r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
  );

  /// Password validation regex pattern
  /// At least 8 characters, one uppercase, one lowercase, one number
  static final RegExp _passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$',
  );

  /// Validates if a field is not empty
  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  /// Validates email format
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validates password strength
  /// Minimum 8 characters, at least one uppercase letter, one lowercase letter, and one number
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!_passwordRegex.hasMatch(value)) {
      return 'Password must contain uppercase, lowercase, and number';
    }
    return null;
  }

  /// Validates password confirmation matches
  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Validates URL format
  static String? url(String? value, {bool required = false}) {
    if (value == null || value.trim().isEmpty) {
      return required ? 'URL is required' : null;
    }
    if (!_urlRegex.hasMatch(value.trim())) {
      return 'Please enter a valid URL';
    }
    return null;
  }

  /// Validates minimum length
  static String? minLength(String? value, int min, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    if (value.length < min) {
      return '${fieldName ?? 'This field'} must be at least $min characters';
    }
    return null;
  }

  /// Validates maximum length
  static String? maxLength(String? value, int max, {String? fieldName}) {
    if (value != null && value.length > max) {
      return '${fieldName ?? 'This field'} must not exceed $max characters';
    }
    return null;
  }

  /// Validates length range
  static String? lengthRange(
    String? value,
    int min,
    int max, {
    String? fieldName,
  }) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    if (value.length < min || value.length > max) {
      return '${fieldName ?? 'This field'} must be between $min and $max characters';
    }
    return null;
  }

  /// Validates numeric input
  static String? numeric(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    if (int.tryParse(value.trim()) == null &&
        double.tryParse(value.trim()) == null) {
      return '${fieldName ?? 'This field'} must be a number';
    }
    return null;
  }

  /// Validates integer input
  static String? integer(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    if (int.tryParse(value.trim()) == null) {
      return '${fieldName ?? 'This field'} must be a whole number';
    }
    return null;
  }

  /// Validates minimum value
  static String? minValue(String? value, num min, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    final numValue = num.tryParse(value.trim());
    if (numValue == null) {
      return '${fieldName ?? 'This field'} must be a number';
    }
    if (numValue < min) {
      return '${fieldName ?? 'This field'} must be at least $min';
    }
    return null;
  }

  /// Validates maximum value
  static String? maxValue(String? value, num max, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    final numValue = num.tryParse(value.trim());
    if (numValue == null) {
      return '${fieldName ?? 'This field'} must be a number';
    }
    if (numValue > max) {
      return '${fieldName ?? 'This field'} must not exceed $max';
    }
    return null;
  }

  /// Validates phone number format (basic validation)
  static String? phone(String? value, {bool required = true}) {
    if (value == null || value.trim().isEmpty) {
      return required ? 'Phone number is required' : null;
    }
    // Remove common phone number characters
    final cleaned = value.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');
    if (cleaned.length < 10 || cleaned.length > 15) {
      return 'Please enter a valid phone number';
    }
    if (!RegExp(r'^\d+$').hasMatch(cleaned)) {
      return 'Phone number must contain only digits';
    }
    return null;
  }

  /// Validates date is in the future
  static String? futureDate(DateTime? value, {String? fieldName}) {
    if (value == null) {
      return '${fieldName ?? 'Date'} is required';
    }
    if (value.isBefore(DateTime.now())) {
      return '${fieldName ?? 'Date'} must be in the future';
    }
    return null;
  }

  /// Validates date is in the past
  static String? pastDate(DateTime? value, {String? fieldName}) {
    if (value == null) {
      return '${fieldName ?? 'Date'} is required';
    }
    if (value.isAfter(DateTime.now())) {
      return '${fieldName ?? 'Date'} must be in the past';
    }
    return null;
  }

  /// Combines multiple validators
  static String? Function(String?) combine(
    List<String? Function(String?)> validators,
  ) {
    return (value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) {
          return error;
        }
      }
      return null;
    };
  }
}
