import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:pde_worksheet/models/worksheet_state.dart';
import 'package:pde_worksheet/store/store.dart';

class WorksheetService {
  Future<List<WorksheetState>> getWorksheets() async {
    String? token = await SecureStorage.read('token');
    final baseUrl = dotenv.env['API'] ?? '';
    List<WorksheetState> worksheets = [];
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/worksheets'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        worksheets = WorksheetState.fromJsonList(data['results']);
      } else {
        // Handle non-200 status codes
        print('Failed to get worksheets: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the HTTP request
      print('An error occurred during get worksheets: $e');
    }
    return worksheets;
  }
}
