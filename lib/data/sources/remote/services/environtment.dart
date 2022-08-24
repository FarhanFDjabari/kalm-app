class Environments {
  static const String PRODUCTION = 'http://calma.mides.id/';
  static const String DEV = 'http://calma.mides.id/';
}

class ConfigEnvironments {
  static const String _currentEnvironments = Environments.DEV;
  static const List<Map<String, String>> _availableEnvironments = [
    {
      'env': Environments.DEV,
      'url': 'http://calma.mides.id/',
    },
    {
      'env': Environments.PRODUCTION,
      'url': 'http://calma.mides.id/',
    },
  ];

  static String? getEnvironments() {
    return _availableEnvironments
        .firstWhere(
          (d) => d['env'] == _currentEnvironments,
        )
        .values
        .last
        .toString();
  }
}
