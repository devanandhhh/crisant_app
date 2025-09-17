import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../model/user.dart';

class UpdateUserService {
  final String baseUrl = 'https://reqres.in/api/';

  /// Update user with PATCH request
  Future<User?> updateUser({
    required String id,
    String? firstName,
    String? lastName,
    String? email,
    String? avatar,
  }) async {
    final url = Uri.parse('${baseUrl}users/$id');

    // Create JSON body with only non-null fields
    final Map<String, dynamic> body = {};
    if (firstName != null) body['first_name'] = firstName;
    if (lastName != null) body['last_name'] = lastName;
    if (email != null) body['email'] = email;
    if (avatar != null) body['avatar'] = avatar;

    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': 'reqres-free-v1',
      },
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      log('User updated: $data status: ${response.statusCode}' as num);
      print(  'User updated: $data status: ${response.statusCode}');
      return User.fromJson(data);
    } else {
      print('Failed to update user: ${response.statusCode}');
      return null;
    }
  }
}
