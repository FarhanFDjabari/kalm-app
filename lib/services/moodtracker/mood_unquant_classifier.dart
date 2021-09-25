import 'package:kalm/services/moodtracker/mood_classifier.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class MoodUnquantClassifier extends MoodClassifier {
  MoodUnquantClassifier({int? numThreads}) : super(numThreads: numThreads);

  @override
  String get modelName => 'ml_model/model_unquant.tflite';

  @override
  NormalizeOp get preProcessNormalizeOp => NormalizeOp(127.5, 127.5);

  @override
  NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 1);
}
