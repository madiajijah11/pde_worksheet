import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pde_worksheet/models/room_state.dart';
import 'package:pde_worksheet/models/worksheet_state.dart';
import 'package:pde_worksheet/services/room_service.dart';
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
  List<Technician> _technicians = [];
  List<Software> _softwares = [];
  List<Hardware> _hardwares = [];
  List<Network> _networks = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Worksheet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _worksheetNumberController,
                decoration:
                    const InputDecoration(labelText: 'Worksheet Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter worksheet number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _startTimeController,
                decoration: const InputDecoration(labelText: 'Start Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter start time';
                  }
                  return null;
                },
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd – kk:mm').format(pickedDate);
                    setState(() {
                      _startTimeController.text = formattedDate;
                    });
                  }
                },
              ),
              TextFormField(
                controller: _endTimeController,
                decoration: const InputDecoration(labelText: 'End Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter end time';
                  }
                  return null;
                },
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd – kk:mm').format(pickedDate);
                    setState(() {
                      _endTimeController.text = formattedDate;
                    });
                  }
                },
              ),
              // Add more fields for technicians, softwares, hardwares, and networks as needed
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process data
                    WorksheetState newWorksheet = WorksheetState(
                      id: 0, // Assuming ID is auto-generated
                      worksheetNumber: _worksheetNumberController.text,
                      room: _roomController.text,
                      startTime: _startTimeController.text,
                      endTime: _endTimeController.text,
                      userId: int.parse(_decodedToken['id']),
                      technicians: _technicians,
                      softwares: _softwares,
                      hardwares: _hardwares,
                      networks: _networks,
                    );
                    print(newWorksheet);
                    // Handle the new worksheet (e.g., send to server or save locally)
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
