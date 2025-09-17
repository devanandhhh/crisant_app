import 'dart:convert';
import 'dart:developer';
import 'package:crisant_app/core/end_point.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';

class CreateUserService {
  final String baseUrl = EndPoint.baseUrl;

  Future<User?> createUser({
    required String username,
    required String email,
    required String password,
    required String avatar,
  }) async {
    final url = Uri.parse('${baseUrl}users');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': 'reqres-free-v1',
      },
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
        'avatar': avatar,
      }),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      log('User created: $data status: ${response.statusCode}');
      return User.fromJson(data);
    } else {
      print('Failed to create user: ${response.statusCode}');
      return null;
    }
  }
}
