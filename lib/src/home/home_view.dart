import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:pde_worksheet/models/worksheet_state.dart';

import 'package:pde_worksheet/routes/app_router.gr.dart';
import 'package:pde_worksheet/utils/date_time_utils.dart';
import 'package:pde_worksheet/src/home/home_controller.dart';

@RoutePage(name: 'HomeRoute')
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutoRouteAwareStateMixin<HomeView> {
  final HomeController _controller = HomeController();
  final ScrollController _scrollController = ScrollController();
  List<WorksheetState> _allWorksheets = [];
  List<WorksheetState> _displayedWorksheets = [];
  int _currentChunkIndex = 0;
  final int _chunkSize = 10;

  @override
  void initState() {
    super.initState();
    fetchData();
    _controller.decodeToken().then((_) {
      setState(() {});
    });
    _controller.addListener(_updateState);

    // Add listener to scroll controller
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          _loadNextChunk();
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_updateState);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  void _loadNextChunk() {
    final nextChunk = _allWorksheets
        .skip(_currentChunkIndex * _chunkSize)
        .take(_chunkSize)
        .toList();
    setState(() {
      _displayedWorksheets.addAll(nextChunk);
      _currentChunkIndex++;
    });
  }

  void _editItem(int id) async {
    AutoRouter.of(context)
        .navigate(WorksheetRoute(itemId: id, onWorksheetChanged: fetchData));
  }

  void _createNewItem() async {
    AutoRouter.of(context)
        .navigate(WorksheetRoute(onWorksheetChanged: fetchData));
  }

  void _deleteItem(int id) {
    print('Deleting item at id: $id');
  }

  void fetchData() {
    _controller.fetchWorksheets().then((worksheets) {
      setState(() {
        _allWorksheets = worksheets;
        _displayedWorksheets.clear();
        _currentChunkIndex = 0;
        _loadNextChunk();
      });
    });
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
            controller: _scrollController,
            padding: const EdgeInsets.all(8.0),
            itemCount: _displayedWorksheets.length + 1,
            itemBuilder: (context, index) {
              if (index == _displayedWorksheets.length) {
                return _currentChunkIndex * _chunkSize < _allWorksheets.length
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox.shrink();
              }
              final worksheet = _displayedWorksheets[index];
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
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          subtitle: Text('Room: ${worksheet.room}'),
                          trailing: const Icon(Icons.assignment),
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
                              leading: const Icon(Icons.person),
                              title: Text(tech.fullName),
                            )),
                        const Divider(height: 20, thickness: 1),
                        const Text(
                          'Softwares:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ...worksheet.softwares.map((software) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.computer),
                              title: Text(software.description!),
                            )),
                        const Divider(height: 20, thickness: 1),
                        const Text(
                          'Hardwares:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ...worksheet.hardwares.map((hardware) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.memory),
                              title: Text(hardware.description!),
                            )),
                        const Divider(height: 20, thickness: 1),
                        const Text(
                          'Networks:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ...worksheet.networks.map((network) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.network_check),
                              title: Text(network.description!),
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
          _createNewItem();
        },
        backgroundColor: Colors.blue,
        tooltip: 'Create Worksheet',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
