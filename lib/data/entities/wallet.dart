class Wallet {
  final String id;           // MongoDB ID
  final String userId;       // From NestJS entity
  final String walletName;   // From NestJS entity
  final double balance;      // From NestJS entity
  final String currency;     // From NestJS entity
  final String type;        // From NestJS entity
  final String publicKey;    // From NestJS entity
  final double originalAmount; // From NestJS entity
  final String network;      // From NestJS entity
  final DateTime createdAt;  // From timestamps
  final DateTime updatedAt;  // From timestamps

  Wallet({
    required this.id,
    required this.userId,
    required this.walletName,
    required this.balance,
    required this.currency,
    required this.type,
    required this.publicKey,
    required this.originalAmount,
    required this.network,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      walletName: json['walletName'] ?? '',
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] ?? '',
      type: json['type'] ?? 'GENERATED',
      publicKey: json['publicKey'] ?? '',
      originalAmount: (json['originalAmount'] as num?)?.toDouble() ?? 0.0,
      network: json['network'] ?? 'devnet',
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'walletName': walletName,
      'balance': balance,
      'currency': currency,
      'type': type,
      'publicKey': publicKey,
      'originalAmount': originalAmount,
      'network': network,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Utility methods
  String get formattedBalance => balance.toStringAsFixed(4);
  String get formattedDate => createdAt.toLocal().toString().split('.')[0];
  
  // Helper method to format public key
  String get shortPublicKey => publicKey.length > 10 
      ? '${publicKey.substring(0, 6)}...${publicKey.substring(publicKey.length - 4)}'
      : publicKey;

  // Copy with method for immutability
  Wallet copyWith({
    String? id,
    String? userId,
    String? walletName,
    double? balance,
    String? currency,
    String? type,
    String? publicKey,
    double? originalAmount,
    String? network,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Wallet(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      walletName: walletName ?? this.walletName,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
      type: type ?? this.type,
      publicKey: publicKey ?? this.publicKey,
      originalAmount: originalAmount ?? this.originalAmount,
      network: network ?? this.network,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Equality operator
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Wallet &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          walletName == other.walletName &&
          balance == other.balance &&
          currency == other.currency &&
          type == other.type &&
          publicKey == other.publicKey &&
          originalAmount == other.originalAmount &&
          network == other.network;

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      walletName.hashCode ^
      balance.hashCode ^
      currency.hashCode ^
      type.hashCode ^
      publicKey.hashCode ^
      originalAmount.hashCode ^
      network.hashCode;

  @override
  String toString() {
    return 'Wallet{id: $id, userId: $userId, walletName: $walletName, balance: $balance, currency: $currency, type: $type, publicKey: $shortPublicKey, network: $network}';
  }
}