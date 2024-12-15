class User {
  final String? id;
  final String? name;
  final String? email;
  final String? numTel;
  final dynamic roleId;
  final dynamic wallet;

  User({
    this.id,
    this.name,
    this.email,
    this.numTel,
    this.roleId,
    this.wallet,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? json['id'],
      name: json['name'],
      email: json['email'],
      numTel: json['numTel'],
      roleId: json['roleId'],
      wallet: json['wallet'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'numTel': numTel,
      'roleId': roleId,
      'wallet': wallet,
    };
  }
}