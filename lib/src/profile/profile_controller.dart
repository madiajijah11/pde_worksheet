import 'package:flutter/material.dart';

import 'package:pde_worksheet/store/store.dart';
import 'package:pde_worksheet/utils/token_utils.dart';

class ProfileController extends ChangeNotifier {
  Map<String, dynamic> decodedToken = {};

  ProfileController() {
    decodeToken();
  }

  Future<void> decodeToken() async {
    try {
      final token = await _getToken();
      if (token != null) {
        decodedToken = JWT().decodeToken(token);
        notifyListeners();
      }
    } catch (e) {
      // Handle error
      print('Error decoding token: $e');
    }
  }

  Future<String?> _getToken() async {
    try {
      return await SecureStorage.read('token');
    } catch (e) {
      // Handle error
      print('Error getting token: $e');
      return null;
    }
  }

  Future<void> logout(BuildContext context) async {
    await SecureStorage.delete('token');
    notifyListeners();
  }
}
