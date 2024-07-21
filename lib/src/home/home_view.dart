import 'package:flutter/material.dart';
import 'package:pde_worksheet/models/worksheet_model.dart';

import '../settings/settings_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const routeName = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    // Convert the JSON data into a list of Worksheet objects
    final worksheets =
        worksheetsData.map((data) => Worksheet.fromJson(data)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: worksheets.length,
        itemBuilder: (context, index) {
          final worksheet = worksheets[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Worksheet Number: ${worksheet.worksheetNumber}'),
                  Text('Room: ${worksheet.room}'),
                  Text('Start Time: ${worksheet.startTime}'),
                  Text('End Time: ${worksheet.endTime}'),
                  Text('User ID: ${worksheet.userId}'),
                  const SizedBox(height: 10),
                  const Text('Technicians:'),
                  ...worksheet.technicians.map((tech) => Text(tech.name)),
                  const SizedBox(height: 10),
                  const Text('Softwares:'),
                  ...worksheet.softwares.map((software) => Text(
                      '${software.name}: ${software.description} - ${software.result}')),
                  const SizedBox(height: 10),
                  const Text('Hardwares:'),
                  ...worksheet.hardwares.map((hardware) => Text(
                      '${hardware.name}: ${hardware.description} - ${hardware.result}')),
                  const SizedBox(height: 10),
                  const Text('Networks:'),
                  ...worksheet.networks.map((network) => Text(
                      '${network.name}: ${network.description} - ${network.result}')),
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
