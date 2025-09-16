import 'package:sqflite/sqflite.dart';
import '../model/user_model.dart';

late Database _db;

Future<List<Map<String, dynamic>>> getAllUsers() async {
  final values = await _db.rawQuery("SELECT * FROM user");
  return values;
}

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
