import 'package:sqflite/sqflite.dart';
import '../model/user_model.dart';

late Database _db;

// Future<void> initializeDatabase() async {
//   _db = await openDatabase(
//     "user.db",
//     version: 1,
//     onCreate: (Database db, int version) async {
//       await db.execute(
//         "CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, photoUrl TEXT);",
//       );
//     },
//   );
// }

// Future<void> addUser(UserModel value) async {
//   await _db.rawInsert(
//     "INSERT INTO user (name, email, photoUrl) VALUES (?, ?, ?)",
//     [
//       value.name,
//       value.email,
//       value.photoUrl,
//     ],
//   );
// }

// Future<List<Map<String, dynamic>>> getAllUsers() async {
//   final values = await _db.rawQuery("SELECT * FROM user");
//   return values;
// }

// Future<void> deleteUser(int id) async {
//   await _db.rawDelete('DELETE FROM user WHERE id = ?', [id]);
// }

// // Future<void> updateUser(UserModel updatedUser) async {
// //   await _db.update(
// //     'user',
// //     {
// //       'name': updatedUser.name,
// //       'email': updatedUser.email,
// //       'photoUrl': updatedUser.photoUrl,
// //     },
// //     where: 'id = ?',
// //     whereArgs: [updatedUser.id],
// //   );
// //}
Future<void> initializeDatabase() async {
  _db = await openDatabase(
    "user.db",
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
        "CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, photoUrl TEXT);",
      );
    },
  );
}

// Save current user (replace previous)
Future<void> saveUser(UserModel user) async {
  await _db.delete('user'); // clear previous user
  await _db.insert('user', user.toMap());
}

// Get current logged-in user
Future<UserModel?> getCurrentUser() async {
  final users = await _db.query('user');
  if (users.isNotEmpty) {
    return UserModel.fromMap(users.first);
  }
  return null;
}

// Clear user on logout
Future<void> clearUser() async {
  await _db.delete('user');
}
