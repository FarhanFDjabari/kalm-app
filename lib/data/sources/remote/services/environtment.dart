class Environments {
  static const String PRODUCTION = 'PRODUCTION';
  static const String DEV = 'DEV';
}

class ConfigEnvironments {
  static const String _currentEnvironments = Environments.DEV;
  static const List<Map<String, String>> _availableEnvironments = [
    {
      'env': Environments.DEV,
      'url': 'https://xtxiyjuvarutzorjpudq.supabase.co',
    },
    {
      'env': Environments.PRODUCTION,
      'url': 'http://calma.mides.id/',
    },
  ];

  static String getEnvironments() {
    return _availableEnvironments
        .firstWhere(
          (d) => d['env'] == _currentEnvironments,
        )
        .values
        .last
        .toString();
  }

  static String getPublicKey() {
    return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh0eGl5anV2YXJ1dHpvcmpwdWRxIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjEyNzQ0MDUsImV4cCI6MTk3Njg1MDQwNX0.XOeN0u6qNEOJ7wJrorI3U5FPAC4Uo97AvU8t8WTAu20';
  }
}
