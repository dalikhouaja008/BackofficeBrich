class ExchangeRate {
  final String code;
  final String designation;
  final String unit;
  final String buyingRate;
  final String sellingRate;
  final String date;

  ExchangeRate({
    required this.code,
    required this.designation,
    required this.unit,
    required this.buyingRate,
    required this.sellingRate,
    required this.date,
  });

  // Optional factory method to create from JSON if you're fetching from an API
  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    return ExchangeRate(
      code: json['code'] ?? '',
      designation: json['designation'] ?? '',
      unit: json['unit'] ?? '1',
      buyingRate: json['buyingRate'] ?? '0',
      sellingRate: json['sellingRate'] ?? '0',
      date: json['date'] ?? DateTime.now().toIso8601String(),
    );
  }

  get currency => null;

  get rate => null;
}
