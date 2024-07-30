import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:pde_worksheet/routes/app_router.gr.dart';
import 'package:pde_worksheet/utils/date_time_utils.dart';

import 'home_controller.dart';

@RoutePage(name: 'HomeRoute')
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController _controller = HomeController();

  @override
  void initState() {
    super.initState();
    _controller.fetchWorksheets().then((_) {});
    _controller.decodeToken().then((_) {});
  }

  void _editItem(int id) {
    AutoRouter.of(context).navigate(WorksheetRoute(itemId: id));
  }

  void _deleteItem(int id) {
    print('Deleting item at id: $id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.person),
            label: const Text("Profile"),
            onPressed: () {
              AutoRouter.of(context).navigate(const ProfileRoute());
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: _controller.isLoading,
        builder: (context, isLoading, child) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: _controller.worksheets.length,
            itemBuilder: (context, index) {
              final worksheet = _controller.worksheets[index];
              final startTime = formatDateTime(worksheet.startTime!);
              final endTime = formatDateTime(worksheet.endTime!);
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                  onTap: () {
                    _controller.showEditDeleteDialog(
                      context,
                      _controller.decodedToken['accessRight'],
                      () => _editItem(worksheet.id),
                      () => _deleteItem(worksheet.id),
                    );
                  },
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
                        Text('Start Time: $startTime'),
                        Text('End Time: $endTime'),
                        const Divider(height: 20, thickness: 1),
                        const Text(
                          'Technicians:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ...worksheet.technicians.map((tech) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(Icons.person),
                              title: Text(tech.fullName),
                            )),
                        const Divider(height: 20, thickness: 1),
                        const Text(
                          'Softwares:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ...worksheet.softwares.map((software) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(Icons.computer),
                              title: Text(software.name!),
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
                              title: Text(hardware.name!),
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
                              title: Text(network.name!),
                              subtitle: Text(
                                  '${network.description} - ${network.result}'),
                            )),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AutoRouter.of(context).navigate(WorksheetRoute());
        },
        backgroundColor: Colors.blue,
        tooltip: 'Create Worksheet',
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
