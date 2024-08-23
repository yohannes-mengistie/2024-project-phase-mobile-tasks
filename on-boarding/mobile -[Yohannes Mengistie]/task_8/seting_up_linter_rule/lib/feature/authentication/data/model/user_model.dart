import '../../domain/entities/authentication.dart';

class UserModel extends UserEntities {
  UserModel({
    required String name,
    required String Email,
    required String Password,
    required String id,
    String? token,
  }) : super(
          Email: Email,
          name: name,
          id: id,
          Password: Password,
          token: token,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '', // Provide a default value if null
      Email: json['email'] ?? '', // Provide a default value if null
      Password: json['password'] ?? '', // Provide a default value if null
      id: json['id'] ?? '', // Provide a default value if null
      token: json['access_token'], // Token can be null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': Email,
      'password': Password,
      'id': id,
      'access_token': token,
    };
  }

  UserModel copyWith({
    String? name,
    String? Email,
    String? Password,
    String? id,
    String? token,
  }) {
    return UserModel(
      name: name ?? this.name,
      Email: Email ?? this.Email,
      Password: Password ?? this.Password,
      id: id ?? this.id,
      token: token ?? this.token,
    );
  }
}
