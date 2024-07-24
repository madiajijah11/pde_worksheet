import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:pde_worksheet/models/room_state.dart';
import 'package:pde_worksheet/store/store.dart';

class RoomService {
  Future<List<RoomState>> getRooms() async {
    String? token = await SecureStorage.read('token');
    final baseUrl = dotenv.env['API'] ?? '';
    List<RoomState> rooms = [];
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/rooms'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        rooms = (data['results'] as List)
            .map((room) => RoomState.fromJson(room))
            .toList();
      } else {
        // Handle non-200 status codes
        print('Failed to get rooms: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the HTTP request
      print('An error occurred during get rooms: $e');
    }
    return rooms;
  }
}
