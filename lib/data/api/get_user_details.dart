import 'dart:convert';
import 'dart:developer';
import 'package:crisant_app/core/end_point.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';

class GetUserDetails {
  final String baseUrl = EndPoint.baseUrl;

  Future<User?> getUserById(int id) async {
    final url = Uri.parse('${baseUrl}users/$id');

    final response = await http.get(
      url,
      headers: {'x-api-key': 'reqres-free-v1'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return User.fromJson(data);
    } else {
      log('Failed to load user: ${response.statusCode}');
      return null;
    }
  }
}
