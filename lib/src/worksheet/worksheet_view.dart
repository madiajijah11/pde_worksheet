// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:pde_worksheet/models/room_state.dart';
import 'package:pde_worksheet/models/technician_state.dart';
import 'package:pde_worksheet/src/components/input_field_list.dart';
import 'package:pde_worksheet/src/worksheet/worksheet_controller.dart';

@RoutePage(name: 'WorksheetRoute')
class WorksheetView extends StatefulWidget {
  final int? itemId;
  const WorksheetView({super.key, this.itemId});

  @override
  State<WorksheetView> createState() => _WorksheetViewState();
}

class _WorksheetViewState extends State<WorksheetView> {
  late WorksheetController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WorksheetController();

    _controller.getToken().then((_) {
      setState(() {});
    });
    _controller.fetchRoom().then((_) {
      setState(() {});
    });
    _controller.fetchTechnician().then((_) {
      setState(() {});
    });
    if (widget.itemId != null) {
      _controller.loadWorksheetData(widget.itemId!);
    }
  }

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
                key: _controller.formKey,
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
                            controller: _controller.startTimeController,
                            decoration: const InputDecoration(
                                labelText: 'Start Time',
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter start time';
                              }
                              return null;
                            },
                            onTap: () => _controller.selectDateTime(
                                context, _controller.startTimeController),
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            controller: _controller.endTimeController,
                            decoration: const InputDecoration(
                                labelText: 'End Time',
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter end time';
                              }
                              return null;
                            },
                            onTap: () => _controller.selectDateTime(
                                context, _controller.endTimeController),
                          ),
                          SizedBox(height: 16.0),
                          DropdownSearch<String>(
                            popupProps: PopupProps.menu(
                                showSelectedItems: true, showSearchBox: true),
                            items: _controller.rooms
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
                                _controller.selectedRoom = newValue!;
                              });
                            },
                            selectedItem: _controller.selectedRoom,
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
                                      items: _controller.technicians
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
                                          _controller.selectedTechnician =
                                              newValue!;
                                        });
                                      },
                                      selectedItem:
                                          _controller.selectedTechnician,
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
                                        _controller.technicians
                                            .where((item) =>
                                                item.fullName ==
                                                _controller.selectedTechnician)
                                            .forEach((item) {
                                          _controller.addedTechnicians
                                              .add(item);
                                        });
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.0),
                              ListView(
                                shrinkWrap: true,
                                children: _controller.addedTechnicians
                                    .map((controller) => ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          leading: const Icon(Icons.person),
                                          title: Text(controller.fullName),
                                          trailing: IconButton(
                                            icon: Icon(Icons.remove_circle),
                                            color: Colors.red,
                                            onPressed: () {
                                              setState(() {
                                                _controller.addedTechnicians
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
                              controllers: _controller.softwareControllers),
                          Divider(),
                          InputFieldList(
                              label: 'Hardware',
                              controllers: _controller.hardwareControllers),
                          Divider(),
                          InputFieldList(
                              label: 'Network',
                              controllers: _controller.networkControllers),
                          Divider(),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              if (_controller.formKey.currentState!
                                  .validate()) {
                                if (widget.itemId != null) {
                                  // Update existing worksheet
                                  // updateWorksheet(widget.itemId!);
                                } else {
                                  // Create new worksheet
                                  _controller.createWorksheet(context);
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
