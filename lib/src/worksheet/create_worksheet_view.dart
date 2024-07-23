import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'package:pde_worksheet/src/settings/settings_view.dart';

@RoutePage(name: 'CreateWorksheetRoute')
class CreateWorksheetView extends StatefulWidget {
  const CreateWorksheetView({super.key});

  @override
  State<CreateWorksheetView> createState() => _CreateWorksheetViewState();
}

class _CreateWorksheetViewState extends State<CreateWorksheetView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Worksheet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Create Worksheet'),
      ),
    );
  }
}
