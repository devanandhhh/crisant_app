// class UserModel {
//   int? id; // primary key
//   String name;
//   String email;
//   String photoUrl; // store network image URL

//   UserModel({this.id, required this.name, required this.email, required this.photoUrl});

//   // Convert UserModel to Map for sqflite
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'email': email,
//       'photoUrl': photoUrl,
//     };
//   }

//   static Future<UserModel?> fromMap(Map<String, Object?> first) {}

//   // Convert Map to UserModel
//   // factory UserModel.fromMap(Map<String, dynamic> map) {
//   //   return UserModel(
//   //     id: map['id'],
//   //     name: map['name'],
//   //     email: map['email'],
//   //     photoUrl: map['photoUrl'],
//   //   );
//   // }
// }
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
