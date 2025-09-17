
class User {
  final dynamic id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;

  User({
    required this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  // Convert JSON map to User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }

  // Convert User to JSON map (optional)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
    };
  }
}
