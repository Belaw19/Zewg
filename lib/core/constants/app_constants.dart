/// Application-wide constants

class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // API Configuration
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.zewg.com',
  );
  
  static const String apiVersion = 'v1';
  
  // API Endpoints
  static const String authLoginEndpoint = '/auth/login';
  static const String authSignupEndpoint = '/auth/signup';
  static const String authLogoutEndpoint = '/auth/logout';
  
  static const String opportunitiesEndpoint = '/opportunities';
  static const String opportunitiesSearchEndpoint = '/opportunities/search';
  static const String opportunitiesFilterEndpoint = '/opportunities/filter';
  
  static const String applicationsEndpoint = '/applications';
  static const String savedOpportunitiesEndpoint = '/saved-opportunities';
  
  static const String profileEndpoint = '/profile';
  static const String profilePictureEndpoint = '/profile/picture';
  static const String profileStatsEndpoint = '/profile/stats';
  
  static const String curatorOpportunitiesEndpoint = '/curator/opportunities';
  static const String curatorAnalyticsEndpoint = '/curator/analytics';
  static const String curatorApplicationsEndpoint = '/curator/applications';
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // Retry Configuration
  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 2);
  
  // Cache Configuration
  static const Duration cacheExpiration = Duration(hours: 24);
  static const int maxConcurrentRequests = 5;
  
  // Local Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String onboardingCompleteKey = 'onboarding_complete';
  static const String themeKey = 'theme_mode';
  
  // Hive Box Names
  static const String authBoxName = 'auth_box';
  static const String opportunitiesBoxName = 'opportunities_box';
  static const String profileBoxName = 'profile_box';
  static const String savedOpportunitiesBoxName = 'saved_opportunities_box';
  
  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int maxNameLength = 100;
  static const int maxBioLength = 500;
  static const int maxDescriptionLength = 5000;
  
  // UI Configuration
  static const Duration snackBarDuration = Duration(seconds: 3);
  static const Duration loadingMessageDelay = Duration(seconds: 2);
  static const double minTouchTargetSize = 48.0;
  
  // Image Configuration
  static const int maxImageSizeBytes = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageFormats = ['jpg', 'jpeg', 'png', 'webp'];
}
