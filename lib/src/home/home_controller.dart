import 'package:flutter/material.dart';

import 'package:pde_worksheet/models/worksheet_state.dart';
import 'package:pde_worksheet/services/worksheet_service.dart';
import 'package:pde_worksheet/store/store.dart';
import 'package:pde_worksheet/utils/token_utils.dart';

class HomeController {
  final WorksheetService _worksheetService = WorksheetService();
  List<WorksheetState> worksheets = [];
  Map<String, dynamic> decodedToken = {};
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  /// Fetches worksheets from the service and updates the state.
  Future<List<WorksheetState>> fetchWorksheets() async {
    try {
      isLoading.value = true;
      final fetchedWorksheets = await _worksheetService.getWorksheets();
      worksheets = fetchedWorksheets;
      filterWorksheets();
      return worksheets; // Return the list of worksheets
    } catch (e) {
      // Handle error
      print('Error fetching worksheets: $e');
      return []; // Return an empty list in case of error
    } finally {
      isLoading.value = false;
    }
  }

  /// Decodes the token and filters worksheets based on user role.
  Future<void> decodeToken() async {
    try {
      final token = await _getToken();
      if (token != null) {
        decodedToken = JWT().decodeToken(token);
      }
    } catch (e) {
      // Handle error
      print('Error decoding token: $e');
    }
  }

  /// Retrieves the token from secure storage.
  Future<String?> _getToken() async {
    try {
      return await SecureStorage.read('token');
    } catch (e) {
      // Handle error
      print('Error getting token: $e');
      return null;
    }
  }

  /// Filters worksheets based on the user's role and ID.
  void filterWorksheets() {
    final userId = decodedToken['id'];
    final userRole = decodedToken['accessRight'];

    // desc order by createdAt
    worksheets.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    worksheets = worksheets.where((worksheet) {
      if (userRole == 'SUPERADMIN' || userRole == 'ADMIN') {
        return true;
      } else {
        return worksheet.userId == userId;
      }
    }).toList();
  }

  void showEditDeleteDialog(
      BuildContext context, String role, Function onEdit, Function onDelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit or Delete Item'),
          content: Text('Choose an action'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onEdit();
              },
              child: Text('Edit'),
            ),
            if (role == 'SUPERADMIN' || role == 'ADMIN')
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onDelete();
                },
                child: Text('Delete'),
              ),
          ],
        );
      },
    );
  }

  void dispose() {
    isLoading.dispose();
  }
}
