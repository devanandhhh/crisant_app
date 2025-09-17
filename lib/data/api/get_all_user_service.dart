import 'package:crisant_app/core/end_point.dart';

import '../model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class GetAllUserService {
  final String baseUrl = EndPoint.baseUrl;

  Future<List<User>> getUsers({int page = 1}) async {
    final url = Uri.parse('${baseUrl}users?page=$page');

    try {
      final response = await http.get(
        url,
        headers: {'x-api-key': 'reqres-free-v1'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List users = data['data'];
        // for(var user in users) {
        //   print('Fetched user: $user');
        // }
        return users.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch users. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }
}
