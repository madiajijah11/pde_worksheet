import 'package:flutter/material.dart';
import 'package:pde_worksheet/src/settings/settings_view.dart';

class CreateWorksheetView extends StatefulWidget {
  const CreateWorksheetView({super.key});

  static const routeName = '/create-worksheet';

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
