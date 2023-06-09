class AccountModel {
  String id;
  final String name;
  final String email;
  final String npk;
  final String password;
  final String createdAt;

  AccountModel({
    required this.id,
    required this.name,
    required this.email,
    required this.npk,
    required this.password,
    required this.createdAt,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'],
      name: json['name'],
      npk: json['npk'],
      email: json['email'],
      password: json['password'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'npk': npk,
      'password': password,
      'createdAt': createdAt,
    };
  }
}
