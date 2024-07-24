import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:pde_worksheet/models/worksheet_state.dart';
import 'package:pde_worksheet/services/worksheet_service.dart';
import 'package:pde_worksheet/store/store.dart';

@RoutePage(name: 'HomeRoute')
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final WorksheetService _worksheetService = WorksheetService();
  List<WorksheetState> _worksheets = [];
  Map<String, dynamic> _decodedToken = {};

  @override
  void initState() {
    super.initState();
    _fetchWorksheets();
    _decodeToken();
  }

  Future<void> _fetchWorksheets() async {
    final worksheets = await _worksheetService.getWorksheets();
    setState(() {
      _worksheets = worksheets;
    });
  }

  Future<void> _decodeToken() async {
    // Replace this with your method of getting the token
    final token = await _getToken();
    if (token != null) {
      setState(() {
        _decodedToken = JwtDecoder.decode(token);
        _filterWorksheets();
      });
    }
  }

  Future<String?> _getToken() async {
    return SecureStorage.read('token');
  }

  void _filterWorksheets() {
    final userId = _decodedToken['id'];
    final userRole = _decodedToken['accessRight'];
    print(userId);
    print(userRole);

    setState(() {
      _worksheets = _worksheets.where((worksheet) {
        if (userRole == 'SUPERADMIN' || userRole == 'ADMIN') {
          return true;
        } else {
          return worksheet.userId == userId;
        }
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _worksheets.length,
        itemBuilder: (context, index) {
          final worksheet = _worksheets[index];
          return Card(
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
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Worksheet Number: ${worksheet.worksheetNumber}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    subtitle: Text('Room: ${worksheet.room}'),
                    trailing: Icon(Icons.assignment),
                  ),
                  const SizedBox(height: 10),
                  Text('Start Time: ${worksheet.startTime}'),
                  Text('End Time: ${worksheet.endTime}'),
                  const Divider(height: 20, thickness: 1),
                  const Text(
                    'Technicians:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...worksheet.technicians.map((tech) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.person),
                        title: Text(tech.name),
                      )),
                  const Divider(height: 20, thickness: 1),
                  const Text(
                    'Softwares:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...worksheet.softwares.map((software) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.computer),
                        title: Text(software.name),
                        subtitle: Text(
                            '${software.description} - ${software.result}'),
                      )),
                  const Divider(height: 20, thickness: 1),
                  const Text(
                    'Hardwares:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...worksheet.hardwares.map((hardware) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.memory),
                        title: Text(hardware.name),
                        subtitle: Text(
                            '${hardware.description} - ${hardware.result}'),
                      )),
                  const Divider(height: 20, thickness: 1),
                  const Text(
                    'Networks:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...worksheet.networks.map((network) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.network_check),
                        title: Text(network.name),
                        subtitle:
                            Text('${network.description} - ${network.result}'),
                      )),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the Create Worksheet screen
          Navigator.pushNamed(context, '/create-worksheet');
        },
        tooltip: 'Create Worksheet',
        child: Icon(Icons.add),
      ),
    );
  }
}
