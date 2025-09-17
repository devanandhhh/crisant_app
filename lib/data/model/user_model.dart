
class UserModel {
  int? id; // primary key
  String name;
  String email;
  String photoUrl; // store network image URL

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  // Convert UserModel to Map for sqflite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  // Convert Map to UserModel
  factory UserModel.fromMap(Map<String, Object?> map) {
    return UserModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] as String,
    );
  }
}
