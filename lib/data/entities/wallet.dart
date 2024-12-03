class Wallet {
  final String walletName;
  final double balance;
  final String user;

  Wallet({
    required this.walletName,
    required this.balance,
    required this.user,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      walletName: json['walletName'],
      balance: (json['balance'] as num).toDouble(),
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'walletName': walletName,
      'balance': balance,
      'user': user,
    };
  }
}
