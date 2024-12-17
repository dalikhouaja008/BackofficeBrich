import 'package:brichbackoffice/data/entities/PredictionData.dart';

class PredictionResponse {
  final Map<String, List<PredictionData>> predictions;
  final String startDate;

  PredictionResponse({
    required this.predictions,
    required this.startDate, required String error,
  });

  factory PredictionResponse.fromJson(Map<String, dynamic> json) {
    return PredictionResponse(
      predictions: (json['predictions'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key, 
          (value as List).map((item) => PredictionData.fromJson(item)).toList()
        )
      ),
      startDate: json['start_date'] as String, error: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'predictions': predictions.map(
        (key, value) => MapEntry(key, value.map((item) => item.toJson()).toList())
      ),
      'start_date': startDate,
    };
  }
}