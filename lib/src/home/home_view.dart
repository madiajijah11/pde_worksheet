import 'package:flutter/material.dart';

import '../settings/settings_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final worksheet = Worksheet.fromJson({
      "worksheetNumber": "1",
      "room": "Sakura",
      "startTime": "2024-07-01T03:37:56-0800",
      "endTime": "2024-07-01T03:37:56-0800",
      "userId": "2",
      "technicianItems": [
        {"id": "1"},
        {"id": "2"}
      ],
      "softwareItems": [
        {
          "name": "Windows 11",
          "description": "OS Corrupt",
          "result": "Fixed using recovery"
        },
        {
          "name": "Windows 7",
          "description": "OS Corrupt",
          "result": "Fixed using recovery"
        }
      ],
      "hardwareItems": [
        {
          "name": "Laptop ROG",
          "description": "Blue Screen",
          "result": "Re install OS"
        },
        {
          "name": "Laptop Alienware",
          "description": "Blue Screen",
          "result": "Re install OS"
        }
      ],
      "networkItems": [
        {"name": "Hub", "description": "No Internet", "result": "Change Route"},
        {
          "name": "Router",
          "description": "No Internet",
          "result": "Change Route"
        }
      ]
    });

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Worksheet Number: ${worksheet.worksheetNumber}'),
              Text('Room: ${worksheet.room}'),
              Text('Start Time: ${worksheet.startTime}'),
              Text('End Time: ${worksheet.endTime}'),
              Text('User ID: ${worksheet.userId}'),
              const SizedBox(height: 10),
              const Text('Technician Items:'),
              ...worksheet.technicianItems
                  .map((item) => Text('ID: ${item.id}')),
              const SizedBox(height: 10),
              const Text('Software Items:'),
              ...worksheet.softwareItems.map((item) =>
                  Text('${item.name}: ${item.description} - ${item.result}')),
              const SizedBox(height: 10),
              const Text('Hardware Items:'),
              ...worksheet.hardwareItems.map((item) =>
                  Text('${item.name}: ${item.description} - ${item.result}')),
              const SizedBox(height: 10),
              const Text('Network Items:'),
              ...worksheet.networkItems.map((item) =>
                  Text('${item.name}: ${item.description} - ${item.result}')),
            ],
          ),
        ),
      ),
    );
  }
}

class Worksheet {
  final String worksheetNumber;
  final String room;
  final String startTime;
  final String endTime;
  final String userId;
  final List<TechnicianItem> technicianItems;
  final List<SoftwareItem> softwareItems;
  final List<HardwareItem> hardwareItems;
  final List<NetworkItem> networkItems;

  Worksheet({
    required this.worksheetNumber,
    required this.room,
    required this.startTime,
    required this.endTime,
    required this.userId,
    required this.technicianItems,
    required this.softwareItems,
    required this.hardwareItems,
    required this.networkItems,
  });

  factory Worksheet.fromJson(Map<String, dynamic> json) => Worksheet(
        worksheetNumber: json['worksheetNumber'],
        room: json['room'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        userId: json['userId'],
        technicianItems: List<TechnicianItem>.from(
            json['technicianItems'].map((x) => TechnicianItem.fromJson(x))),
        softwareItems: List<SoftwareItem>.from(
            json['softwareItems'].map((x) => SoftwareItem.fromJson(x))),
        hardwareItems: List<HardwareItem>.from(
            json['hardwareItems'].map((x) => HardwareItem.fromJson(x))),
        networkItems: List<NetworkItem>.from(
            json['networkItems'].map((x) => NetworkItem.fromJson(x))),
      );
}

class TechnicianItem {
  final String id;

  TechnicianItem({required this.id});

  factory TechnicianItem.fromJson(Map<String, dynamic> json) => TechnicianItem(
        id: json['id'],
      );
}

class SoftwareItem {
  final String name;
  final String description;
  final String result;

  SoftwareItem(
      {required this.name, required this.description, required this.result});

  factory SoftwareItem.fromJson(Map<String, dynamic> json) => SoftwareItem(
        name: json['name'],
        description: json['description'],
        result: json['result'],
      );
}

class HardwareItem {
  final String name;
  final String description;
  final String result;

  HardwareItem(
      {required this.name, required this.description, required this.result});

  factory HardwareItem.fromJson(Map<String, dynamic> json) => HardwareItem(
        name: json['name'],
        description: json['description'],
        result: json['result'],
      );
}

class NetworkItem {
  final String name;
  final String description;
  final String result;

  NetworkItem(
      {required this.name, required this.description, required this.result});

  factory NetworkItem.fromJson(Map<String, dynamic> json) => NetworkItem(
        name: json['name'],
        description: json['description'],
        result: json['result'],
      );
}
