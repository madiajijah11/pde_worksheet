// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:pde_worksheet/models/room_state.dart';
import 'package:pde_worksheet/models/technician_state.dart';
import 'package:pde_worksheet/models/worksheet_state.dart';
import 'package:pde_worksheet/routes/app_router.gr.dart';
import 'package:pde_worksheet/services/room_service.dart';
import 'package:pde_worksheet/services/technician_service.dart';
import 'package:pde_worksheet/services/worksheet_service.dart';
import 'package:pde_worksheet/store/store.dart';
import 'package:pde_worksheet/utils/token_utils.dart';

class WorksheetController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  List<Map<String, TextEditingController>> softwareControllers = [];
  List<Map<String, TextEditingController>> hardwareControllers = [];
  List<Map<String, TextEditingController>> networkControllers = [];

  String selectedRoom = '';
  String selectedTechnician = '';
  List<RoomState> rooms = [];
  List<TechnicianState> technicians = [];
  List<TechnicianState> addedTechnicians = [];
  Map<String, dynamic> decodedToken = {};

  Future<void> loadWorksheetData(int id) async {
    try {
      final worksheet = await WorksheetService().getWorksheet(id);
      if (worksheet == null) {
        // Handle the case where worksheet is null
        return;
      }

      startTimeController.text = worksheet.startTime;
      endTimeController.text = worksheet.endTime;
      selectedRoom = worksheet.room;

      addedTechnicians.clear();
      for (var item in worksheet.technicians) {
        for (var tech in technicians) {
          if (item.id == tech.id) {
            addedTechnicians.add(tech);
          }
        }
      }

      softwareControllers = worksheet.softwares
          .map((item) => {
                'name': TextEditingController(text: item.name),
                'description': TextEditingController(text: item.description),
                'result': TextEditingController(text: item.result),
              })
          .toList();

      hardwareControllers = worksheet.hardwares
          .map((item) => {
                'name': TextEditingController(text: item.name),
                'description': TextEditingController(text: item.description),
                'result': TextEditingController(text: item.result),
              })
          .toList();

      networkControllers = worksheet.networks
          .map((item) => {
                'name': TextEditingController(text: item.name),
                'description': TextEditingController(text: item.description),
                'result': TextEditingController(text: item.result),
              })
          .toList();
    } catch (e) {
      // Handle any errors that occur during the asynchronous operation
      print('Error loading worksheet data: $e');
    }
  }

  Future<void> decodeToken() async {
    try {
      final token = await getToken();
      if (token != null) {
        decodedToken = JWT().decodeToken(token);
      } else {
        print('Token is null');
      }
    } catch (e) {
      print('Error decoding token: $e');
    }
  }

  Future<String?> getToken() async {
    try {
      final token = await SecureStorage.read('token');
      if (token != null) {
        return token;
      } else {
        print('Token is null');
        return null;
      }
    } catch (e) {
      print('Error retrieving token: $e');
      return null;
    }
  }

  Future<void> fetchRoom() async {
    try {
      final fetchedRooms = await RoomService().getRooms();
      rooms = fetchedRooms;
    } catch (e) {
      print('Error fetching rooms: $e');
    }
  }

  Future<void> fetchTechnician() async {
    try {
      final fetchedTechnicians = await TechnicianService().getTechnicians();
      technicians = fetchedTechnicians;
    } catch (e) {
      print('Error fetching technicians: $e');
    }
  }

  Future<void> selectDateTime(
      BuildContext context, TextEditingController controller) async {
    try {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null) {
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            );
          },
        );
        if (time != null) {
          final DateTime dateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            time.hour,
            time.minute,
          );
          controller.text =
              DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(dateTime);
        } else {
          print('Time selection was canceled');
        }
      } else {
        print('Date selection was canceled');
      }
    } catch (e) {
      print('Error selecting date and time: $e');
    }
  }

  Future<void> createWorksheet(BuildContext context) async {
    try {
      // Validate required fields
      if (selectedRoom.isEmpty) {
        throw Exception('Room is required');
      }
      if (startTimeController.text.isEmpty) {
        throw Exception('Start time is required');
      }
      if (endTimeController.text.isEmpty) {
        throw Exception('End time is required');
      }
      if (addedTechnicians.isEmpty) {
        throw Exception('At least one technician is required');
      }
      if (decodedToken['id'] == null) {
        throw Exception('User ID is missing in the token');
      }

      WorksheetService worksheetService = WorksheetService();
      NewWorksheetState newWorksheet = NewWorksheetState(
        room: selectedRoom,
        startTime: startTimeController.text,
        endTime: endTimeController.text,
        userId: int.parse(decodedToken['id'].toString()),
        technicianItems: addedTechnicians
            .map((controller) => TechnicianItem(
                  id: controller.id,
                ))
            .toList(),
        softwareItems: softwareControllers
            .map((controller) => SoftwareItem(
                  name: controller['name']!.text,
                  description: controller['description']!.text,
                  result: controller['result']!.text,
                ))
            .toList(),
        hardwareItems: hardwareControllers
            .map((controller) => HardwareItem(
                  name: controller['name']!.text,
                  description: controller['description']!.text,
                  result: controller['result']!.text,
                ))
            .toList(),
        networkItems: networkControllers
            .map((controller) => NetworkItem(
                  name: controller['name']!.text,
                  description: controller['description']!.text,
                  result: controller['result']!.text,
                ))
            .toList(),
      );

      var response = await worksheetService.newWorksheet(newWorksheet);
      if (response != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Worksheet created'),
          ),
        );
        await Future.delayed(const Duration(seconds: 1));
        AutoRouter.of(context).replaceAll([const HomeRoute()]);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to create worksheet'),
          ),
        );
      }
    } catch (e) {
      print('Error creating worksheet: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
        ),
      );
    }
  }

  Future<void> updateWorksheet(BuildContext context, int itemId) async {
    try {
      // Validate required fields
      if (selectedRoom.isEmpty) {
        throw Exception('Room is required');
      }
      if (startTimeController.text.isEmpty) {
        throw Exception('Start time is required');
      }
      if (endTimeController.text.isEmpty) {
        throw Exception('End time is required');
      }
      if (addedTechnicians.isEmpty) {
        throw Exception('At least one technician is required');
      }
      if (decodedToken['id'] == null) {
        throw Exception('User ID is missing in the token');
      }

      WorksheetService worksheetService = WorksheetService();
      NewWorksheetState updatedWorksheet = NewWorksheetState(
        room: selectedRoom,
        startTime: startTimeController.text,
        endTime: endTimeController.text,
        userId: int.parse(decodedToken['id'].toString()),
        technicianItems: addedTechnicians
            .map((controller) => TechnicianItem(
                  id: controller.id,
                ))
            .toList(),
        softwareItems: softwareControllers
            .map((controller) => SoftwareItem(
                  name: controller['name']!.text,
                  description: controller['description']!.text,
                  result: controller['result']!.text,
                ))
            .toList(),
        hardwareItems: hardwareControllers
            .map((controller) => HardwareItem(
                  name: controller['name']!.text,
                  description: controller['description']!.text,
                  result: controller['result']!.text,
                ))
            .toList(),
        networkItems: networkControllers
            .map((controller) => NetworkItem(
                  name: controller['name']!.text,
                  description: controller['description']!.text,
                  result: controller['result']!.text,
                ))
            .toList(),
      );
      var response =
          await worksheetService.updateWorksheet(itemId, updatedWorksheet);
      if (response != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Worksheet updated'),
          ),
        );
        await Future.delayed(const Duration(seconds: 1));
        AutoRouter.of(context).replaceAll([const HomeRoute()]);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update worksheet'),
          ),
        );
      }
    } catch (e) {
      print('Error updating worksheet: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
        ),
      );
    }
  }
}
