class Environments {
  static const String PRODUCTION = 'http://calma.com-indo.com/';
  static const String DEV = 'http://calma.com-indo.com/';
}

class ConfigEnvironments {
  static const String _currentEnvironments = Environments.DEV;
  static const List<Map<String, String>> _availableEnvironments = [
    {
      'env': Environments.DEV,
      'url': 'http://calma.com-indo.com/',
    },
    {
      'env': Environments.PRODUCTION,
      'url': 'http://calma.com-indo.com/',
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
