import 'package:http/http.dart' as http;

class DeleteUserService {
  final String baseUrl = 'https://reqres.in/api/';

  /// Delete user by id
  Future<bool> deleteUser({required int id}) async {
    final url = Uri.parse('${baseUrl}users/$id');

    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': 'reqres-free-v1',
      },
    );

    if (response.statusCode == 204) {
      // 204 No Content indicates successful deletion
      return true;
    } else {
      print('Failed to delete user: ${response.statusCode}');
      return false;
    }
  }
}
