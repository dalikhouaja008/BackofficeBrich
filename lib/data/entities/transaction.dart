class Transaction {
  final double amount;
  final String type;
  final String wallet;
  final DateTime createdAt;

  Transaction({
    required this.amount,
    required this.type,
    required this.wallet,
    required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      amount: (json['amount'] as num).toDouble(),
      type: json['type'],
      wallet: json['wallet'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'type': type,
      'wallet': wallet,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
