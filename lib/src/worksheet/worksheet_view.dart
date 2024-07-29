// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:pde_worksheet/models/room_state.dart';
import 'package:pde_worksheet/models/technician_state.dart';
import 'package:pde_worksheet/models/worksheet_state.dart';
import 'package:pde_worksheet/routes/app_router.gr.dart';
import 'package:pde_worksheet/services/room_service.dart';
import 'package:pde_worksheet/services/technician_service.dart';
import 'package:pde_worksheet/services/worksheet_service.dart';
import 'package:pde_worksheet/src/components/input_field_list.dart';
import 'package:pde_worksheet/store/store.dart';
import 'package:pde_worksheet/utils/token_utils.dart';

@RoutePage(name: 'WorksheetRoute')
class WorksheetView extends StatefulWidget {
  final int? itemId;
  const WorksheetView({super.key, this.itemId});

  @override
  State<WorksheetView> createState() => _WorksheetViewState();
}

class _WorksheetViewState extends State<WorksheetView> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();

  List<Map<String, TextEditingController>> _softwareControllers = [];
  List<Map<String, TextEditingController>> _hardwareControllers = [];
  List<Map<String, TextEditingController>> _networkControllers = [];

  String _selectedRoom = '';
  String _selectedTechnician = '';
  List<RoomState> _rooms = [];
  List<TechnicianState> _technicians = [];
  List<TechnicianState> _addedTechnicians = [];
  Map<String, dynamic> _decodedToken = {};

  @override
  void initState() {
    super.initState();
    if (widget.itemId != null) {
      _loadWorksheetData(widget.itemId!);
    }
    _getToken();
    _decodeToken();
    _fetchRoom();
    _fetchTechnician();
  }

  Future<void> _loadWorksheetData(int id) async {
    final worksheet = await WorksheetService().getWorksheet(id);
    // print(worksheet?.technicians);
    setState(() {
      _startTimeController.text = worksheet?.startTime as String;
      _endTimeController.text = worksheet?.endTime as String;
      _selectedRoom = worksheet!.room;
      _addedTechnicians = worksheet.technicians
          .where((tech) => tech.id != null)
          .where((tech) => _technicians.any((item) => item.id == tech.id))
          .map((tech) => {_addedTechnicians.add(tech as TechnicianState)})
          .cast<TechnicianState>()
          .toList();
      print(_addedTechnicians);
      _softwareControllers = worksheet.softwares
          .map((item) => {
                'name': TextEditingController(text: item.name),
                'description': TextEditingController(text: item.description),
                'result': TextEditingController(text: item.result),
              })
          .toList();
      _hardwareControllers = worksheet.hardwares
          .map((item) => {
                'name': TextEditingController(text: item.name),
                'description': TextEditingController(text: item.description),
                'result': TextEditingController(text: item.result),
              })
          .toList();
      _networkControllers = worksheet.networks
          .map((item) => {
                'name': TextEditingController(text: item.name),
                'description': TextEditingController(text: item.description),
                'result': TextEditingController(text: item.result),
              })
          .toList();
    });
  }

  Future<void> _decodeToken() async {
    final token = await _getToken();
    if (token != null) {
      _decodedToken = JWT().decodeToken(token);
    }
  }

  Future<String?> _getToken() async {
    return SecureStorage.read('token');
  }

  Future<void> _fetchRoom() async {
    final fetchedRooms = await RoomService().getRooms();
    setState(() {
      _rooms = fetchedRooms;
    });
  }

  Future<void> _fetchTechnician() async {
    final fetchedTechnicians = await TechnicianService().getTechnicians();
    setState(() {
      _technicians = fetchedTechnicians;
    });
  }

  Future<void> selectDateTime(
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
        controller.text = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(dateTime);
      }
    }
  }

  Future<void> createWorksheet() async {
    WorksheetService worksheetService = WorksheetService();
    NewWorksheetState newWorksheet = NewWorksheetState(
      room: _selectedRoom,
      startTime: _startTimeController.text,
      endTime: _endTimeController.text,
      userId: int.parse(_decodedToken['id'].toString()),
      technicianItems: _addedTechnicians
          .map((controller) => TechnicianItem(
                id: controller.id,
              ))
          .toList(),
      softwareItems: _softwareControllers
          .map((controller) => SoftwareItem(
                name: controller['name']!.text,
                description: controller['description']!.text,
                result: controller['result']!.text,
              ))
          .toList(),
      hardwareItems: _hardwareControllers
          .map((controller) => HardwareItem(
                name: controller['name']!.text,
                description: controller['description']!.text,
                result: controller['result']!.text,
              ))
          .toList(),
      networkItems: _networkControllers
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
      AutoRouter.of(context).replace(const HomeRoute());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to create worksheet'),
        ),
      );
    }
  }

  // Future<void> updateWorksheet(int index) async {
//   WorksheetService worksheetService = WorksheetService();
//   NewWorksheetState newWorksheet = NewWorksheetState(
//     room: _selectedRoom,
//     startTime: _startTimeController.text,
//     endTime: _endTimeController.text,
//     userId: int.parse(_decodedToken['id'].toString()),
//     technicianItems: _technicianControllers
//         .map((controller) => TechnicianItem(
//               id: controller.text,
//             ))
//         .toList(),
//     softwareItems: _softwareControllers
//         .map((controller) => SoftwareItem(
//               name: controller['name']!.text,
//               description: controller['description']!.text,
//               result: controller['result']!.text,
//             ))
//         .toList(),
//     hardwareItems: _hardwareControllers
//         .map((controller) => HardwareItem(
//               name: controller['name']!.text,
//               description: controller['description']!.text,
//               result: controller['result']!.text,
//             ))
//         .toList(),
//     networkItems: _networkControllers
//         .map((controller) => NetworkItem(
//               name: controller['name']!.text,
//               description: controller['description']!.text,
//               result: controller['result']!.text,
//             ))
//         .toList(),
//   );
//   var response = await worksheetService.updateWorksheet(index, newWorksheet);
//   // print(response);
//   if (response != null) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Worksheet updated'),
//       ),
//     );
//     await Future.delayed(const Duration(seconds: 1));
//     AutoRouter.of(context).replace(const HomeRoute());
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Failed to update worksheet'),
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              widget.itemId != null ? 'Edit Worksheet' : 'Create Worksheet'),
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
                          SizedBox(height: 16.0),
                          TextFormField(
                            controller: _startTimeController,
                            decoration: const InputDecoration(
                                labelText: 'Start Time',
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter start time';
                              }
                              return null;
                            },
                            onTap: () =>
                                selectDateTime(context, _startTimeController),
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            controller: _endTimeController,
                            decoration: const InputDecoration(
                                labelText: 'End Time',
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter end time';
                              }
                              return null;
                            },
                            onTap: () =>
                                selectDateTime(context, _endTimeController),
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
                                border: OutlineInputBorder(),
                                labelText: "Select Room",
                                hintText: "Select a room",
                              ),
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedRoom = newValue!;
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
                          SizedBox(height: 16.0),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: DropdownSearch<String>(
                                      popupProps: PopupProps.menu(
                                          showSelectedItems: true,
                                          showSearchBox: true),
                                      items: _technicians
                                          .map((TechnicianState tech) =>
                                              tech.fullName)
                                          .toList(),
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Select Technician",
                                          hintText: "Select a technician",
                                        ),
                                      ),
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedTechnician = newValue!;
                                        });
                                      },
                                      selectedItem: _selectedTechnician,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please select a technician';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  IconButton(
                                    icon: Icon(Icons.add_circle),
                                    color: Colors.green,
                                    onPressed: () {
                                      setState(() {
                                        _technicians
                                            .where((item) =>
                                                item.fullName ==
                                                _selectedTechnician)
                                            .forEach((item) {
                                          _addedTechnicians.add(item);
                                        });
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.0),
                              ListView(
                                shrinkWrap: true,
                                children: _addedTechnicians
                                    .map((controller) => ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          leading: const Icon(Icons.person),
                                          title: Text(controller.fullName),
                                          trailing: IconButton(
                                            icon: Icon(Icons.remove_circle),
                                            color: Colors.red,
                                            onPressed: () {
                                              setState(() {
                                                _addedTechnicians
                                                    .remove(controller);
                                              });
                                            },
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                          Divider(),
                          InputFieldList(
                              label: 'Software',
                              controllers: _softwareControllers),
                          Divider(),
                          InputFieldList(
                              label: 'Hardware',
                              controllers: _hardwareControllers),
                          Divider(),
                          InputFieldList(
                              label: 'Network',
                              controllers: _networkControllers),
                          Divider(),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (widget.itemId != null) {
                                  // Update existing worksheet
                                  // updateWorksheet(widget.itemId!);
                                } else {
                                  // Create new worksheet
                                  createWorksheet();
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
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
