class PredictionData {
  final String date;
  final double value;

  PredictionData({
    required this.date,
    required this.value,
  });

  factory PredictionData.fromJson(Map<String, dynamic> json) {
    return PredictionData(
      date: json['date'] as String,
      value: (json['value'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'value': value,
    };
  }
  @override
String toString() {
  return 'PredictionData(date: $date, value: $value)'; // Adjust based on your actual properties
}
}