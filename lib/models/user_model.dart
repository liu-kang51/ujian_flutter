class UserModel {
  final int? id;
  final String email;
  final String password;
  final String username;
  final String phone;

  UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.username,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'username': username,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      username: map['username'],
      phone: map['phone'],
    );
  }
}
