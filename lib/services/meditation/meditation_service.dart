class MeditationService {
  static MeditationService? _service;

  MeditationService._createObject();

  factory MeditationService() => _service ?? MeditationService._createObject();
}
