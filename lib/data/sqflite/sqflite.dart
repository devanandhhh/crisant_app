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

void fetchAndShowFirstUser() async {
  // Get all users
  List<Map<String, dynamic>> users = await getAllUsers();

  if (users.isNotEmpty) {
    // Access the first user
    Map<String, dynamic> firstUser = users[0];

    // Get the fields
    String name = firstUser['name'];
    String email = firstUser['email'];
    String photoUrl = firstUser['photoUrl'];

    print("Name: $name");
    print("Email: $email");
    print("Photo URL: $photoUrl");
  } else {
    print("No users found.");
  }
}