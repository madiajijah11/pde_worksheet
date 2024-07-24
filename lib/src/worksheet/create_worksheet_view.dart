// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:pde_worksheet/models/room_state.dart';
import 'package:pde_worksheet/models/worksheet_state.dart';
import 'package:pde_worksheet/services/room_service.dart';
import 'package:pde_worksheet/src/components/input_field_list.dart';
import 'package:pde_worksheet/store/store.dart';
import 'package:pde_worksheet/utils/token_utils.dart';

@RoutePage(name: 'CreateWorksheetRoute')
class CreateWorksheetView extends StatefulWidget {
  const CreateWorksheetView({super.key});

  @override
  State<CreateWorksheetView> createState() => _CreateWorksheetViewState();
}

class _CreateWorksheetViewState extends State<CreateWorksheetView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _worksheetNumberController =
      TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  String? _selectedRoom;
  List<RoomState> _rooms = [];
  Map<String, dynamic> _decodedToken = {};

  final List<TextEditingController> _technicianControllers = [];
  final List<Map<String, TextEditingController>> _softwareControllers = [];
  final List<Map<String, TextEditingController>> _hardwareControllers = [];
  final List<Map<String, TextEditingController>> _networkControllers = [];

  @override
  void initState() {
    super.initState();
    _getToken();
    decodeToken();
    fetchRoom();
  }

  Future<void> decodeToken() async {
    final token = await _getToken();
    if (token != null) {
      _decodedToken = JWT().decodeToken(token);
    }
  }

  Future<String?> _getToken() async {
    return SecureStorage.read('token');
  }

  Future<void> fetchRoom() async {
    final fetchedRooms = await RoomService().getRooms();
    setState(() {
      _rooms = fetchedRooms;
    });
  }

  Future<void> _selectDateTime(
      BuildContext context, TextEditingController controller) async {
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
      );
      if (time != null) {
        final DateTime dateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          time.hour,
          time.minute,
        );
        controller.text = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Worksheet'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: _formKey,
                child: ListView(children: [
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _worksheetNumberController,
                            decoration: const InputDecoration(
                                labelText: 'Worksheet Number'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter worksheet number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            controller: _startTimeController,
                            decoration:
                                const InputDecoration(labelText: 'Start Time'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter start time';
                              }
                              return null;
                            },
                            onTap: () =>
                                _selectDateTime(context, _startTimeController),
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            controller: _endTimeController,
                            decoration:
                                const InputDecoration(labelText: 'End Time'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter end time';
                              }
                              return null;
                            },
                            onTap: () =>
                                _selectDateTime(context, _endTimeController),
                          ),
                          SizedBox(height: 16.0),
                          DropdownSearch<String>(
                            popupProps: PopupProps.menu(
                                showSelectedItems: true, showSearchBox: true),
                            items: _rooms
                                .map((RoomState room) => room.name)
                                .toList(),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Select Room",
                                hintText: "Select a room",
                              ),
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedRoom = newValue;
                              });
                            },
                            selectedItem: _selectedRoom,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a room';
                              }
                              return null;
                            },
                          ),
                          InputFieldList(
                              label: 'Software',
                              controllers: _softwareControllers),
                          InputFieldList(
                              label: 'Hardware',
                              controllers: _hardwareControllers),
                          InputFieldList(
                              label: 'Network',
                              controllers: _networkControllers),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Process data
                                NewWorksheetState newWorksheet =
                                    NewWorksheetState(
                                  worksheetNumber:
                                      _worksheetNumberController.text,
                                  room: _roomController.text,
                                  startTime: _startTimeController.text,
                                  endTime: _endTimeController.text,
                                  userId:
                                      int.parse(_decodedToken['id'].toString()),
                                  technicianItems: _technicianControllers
                                      .map((controller) => TechnicianItem(
                                            id: controller.text,
                                          ))
                                      .toList(),
                                  softwareItems: _softwareControllers
                                      .map((controller) => SoftwareItem(
                                            name: controller['name']!.text,
                                            description:
                                                controller['description']!.text,
                                            result: controller['result']!.text,
                                          ))
                                      .toList(),
                                  hardwareItems: _hardwareControllers
                                      .map((controller) => HardwareItem(
                                            name: controller['name']!.text,
                                            description:
                                                controller['description']!.text,
                                            result: controller['result']!.text,
                                          ))
                                      .toList(),
                                  networkItems: _networkControllers
                                      .map((controller) => NetworkItem(
                                            name: controller['name']!.text,
                                            description:
                                                controller['description']!.text,
                                            result: controller['result']!.text,
                                          ))
                                      .toList(),
                                );
                                print(newWorksheet);
                                // Handle the new worksheet (e.g., send to server or save locally)
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 12.0),
                              textStyle: const TextStyle(fontSize: 16.0),
                            ),
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]))));
  }
}
