import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pde_worksheet/models/auth_state.dart';
import 'package:pde_worksheet/notifiers/auth_notifier.dart';
import 'package:pde_worksheet/store/store.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthService {
  Future<String?> login(String username, String password) async {
    final baseUrl = dotenv.env['API'] ?? '';
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/signin'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await SecureStorage.write('token', data['token']);
        return data['token'];
      } else {
        // Handle non-200 status codes
        print('Failed to login: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle any exceptions that occur during the HTTP request or secure storage write
      print('An error occurred during login: $e');
      return null;
    }
  }
}
