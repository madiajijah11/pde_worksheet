import 'package:flutter/material.dart';
import 'package:pde_worksheet/models/worksheet_state.dart';
import 'package:pde_worksheet/services/worksheet_service.dart';
import 'package:pde_worksheet/store/store.dart';
import 'package:pde_worksheet/utils/token_utils.dart';
import 'dart:async';

class HomeController extends ChangeNotifier {
  final WorksheetService _worksheetService = WorksheetService();
  List<WorksheetState> worksheets = [];
  Map<String, dynamic> decodedToken = {};
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final StreamController<List<WorksheetState>> _worksheetStreamController =
      StreamController.broadcast();

  Stream<List<WorksheetState>> get worksheetStream =>
      _worksheetStreamController.stream;

  @override
  void dispose() {
    super.dispose();
    isLoading.dispose();
    _worksheetStreamController.close();
  }

  Future<List<WorksheetState>> fetchWorksheets() async {
    return _executeWithLoading(() async {
      final fetchedWorksheets = await _worksheetService.getWorksheets();
      worksheets = fetchedWorksheets;
      filterWorksheets(); // Add this line to filter worksheets after fetching
      _worksheetStreamController.add(worksheets);
      return worksheets;
    });
  }

  Future<void> decodeToken() async {
    await _executeWithErrorHandling(() async {
      final token = await _getToken();
      if (token != null) {
        decodedToken = JWT().decodeToken(token);
        filterWorksheets();
      }
    });
  }

  Future<String?> _getToken() async {
    return _executeWithErrorHandling(() async {
      return await SecureStorage.read('token');
    });
  }

  void filterWorksheets() {
    final userId = decodedToken['id'];
    final userRole = decodedToken['accessRight'];

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
    _showDialog(
      context,
      'Edit or Delete Item',
      'Choose an action',
      [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onEdit();
          },
          child: Text('Edit'),
        ),
        // if (role == 'SUPERADMIN' || role == 'ADMIN')
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onDelete();
          },
          child: Text('Delete'),
        ),
      ],
    );
  }

  Future<T> _executeWithLoading<T>(Future<T> Function() action) async {
    try {
      isLoading.value = true;
      return await action();
    } catch (e) {
      print('Error: $e');
      return Future.error(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<T> _executeWithErrorHandling<T>(Future<T> Function() action) async {
    try {
      return await action();
    } catch (e) {
      print('Error: $e');
      return Future.error(e);
    }
  }

  void _showDialog(BuildContext context, String title, String content,
      List<Widget> actions) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: actions,
        );
      },
    );
  }
}
