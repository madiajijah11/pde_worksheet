import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:pde_worksheet/models/technician_state.dart';
import 'package:pde_worksheet/store/store.dart';

class TechnicianService {
  Future<List<TechnicianState>> getTechnicians() async {
    String? token = await SecureStorage.read('token');
    final baseUrl = dotenv.env['API'] ?? '';
    List<TechnicianState> technicians = [];
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/technicians'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        technicians = (data['results'] as List)
            .map((tech) => TechnicianState.fromJson(tech))
            .toList();
      } else {
        // Handle non-200 status codes
        print('Failed to get technicians: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the HTTP request
      print('An error occurred during get technicians: $e');
    }
    return technicians;
  }
}
