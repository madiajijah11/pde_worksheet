class WorksheetState {
  final int id;
  final String? worksheetNumber;
  final String? room;
  final String? startTime;
  final String? endTime;
  final int? userId;
  final String? createdAt;
  final String? updatedAt;
  final List<Technician> technicians;
  final List<Software> softwares;
  final List<Hardware> hardwares;
  final List<Network> networks;

  WorksheetState({
    required this.id,
    required this.worksheetNumber,
    required this.room,
    required this.startTime,
    required this.endTime,
    required this.userId,
    this.createdAt,
    this.updatedAt,
    required this.technicians,
    required this.softwares,
    required this.hardwares,
    required this.networks,
  });

  factory WorksheetState.fromJson(Map<String, dynamic> json) {
    return WorksheetState(
      id: json['id'],
      worksheetNumber: json['worksheetNumber'],
      room: json['room'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      userId: json['userId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      technicians: (json['technicians'] as List)
          .map((tech) => Technician.fromJson(tech))
          .toList(),
      softwares: (json['softwares'] as List)
          .map((software) => Software.fromJson(software))
          .toList(),
      hardwares: (json['hardwares'] as List)
          .map((hardware) => Hardware.fromJson(hardware))
          .toList(),
      networks: (json['networks'] as List)
          .map((network) => Network.fromJson(network))
          .toList(),
    );
  }

  static List<WorksheetState> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => WorksheetState.fromJson(json)).toList();
  }

  @override
  String toString() {
    return 'WorksheetState(id: $id, worksheetNumber: $worksheetNumber, room: $room, startTime: $startTime, endTime: $endTime, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt, technicians: $technicians, softwares: $softwares, hardwares: $hardwares, networks: $networks)';
  }
}

class Technician {
  final int? id;
  final String? titles;
  final String? name;
  final String? degrees;

  Technician({
    required this.id,
    required this.titles,
    required this.name,
    required this.degrees,
  });

  factory Technician.fromJson(Map<String, dynamic> json) {
    return Technician(
      id: json['id'],
      titles: json['titles'],
      name: json['name'],
      degrees: json['degrees'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titles': titles,
      'name': name,
      'degrees': degrees,
    };
  }

  String get fullName {
    return '${titles ?? ''} $name ${degrees ?? ''}'.trim();
  }

  @override
  String toString() {
    return 'Technician(id: $id, titles: $titles, name: $name, degrees: $degrees)';
  }
}

class Software {
  final String? description;

  Software({required this.description});

  factory Software.fromJson(Map<String, dynamic> json) {
    return Software(description: json['description']);
  }

  @override
  String toString() {
    return 'Software(description: $description)';
  }
}

class Hardware {
  final String? description;

  Hardware({required this.description});

  factory Hardware.fromJson(Map<String, dynamic> json) {
    return Hardware(description: json['description']);
  }

  @override
  String toString() {
    return 'Hardware(description: $description)';
  }
}

class Network {
  final String? description;

  Network({required this.description});

  factory Network.fromJson(Map<String, dynamic> json) {
    return Network(description: json['description']);
  }

  @override
  String toString() {
    return 'Network(description: $description)';
  }
}

class NewWorksheetState {
  final String? room;
  final String? startTime;
  final String? endTime;
  final int? userId;
  final List<TechnicianItem> technicianItems;
  final List<SoftwareItem> softwareItems;
  final List<HardwareItem> hardwareItems;
  final List<NetworkItem> networkItems;

  NewWorksheetState({
    required this.room,
    required this.startTime,
    required this.endTime,
    required this.userId,
    required this.technicianItems,
    required this.softwareItems,
    required this.hardwareItems,
    required this.networkItems,
  });

  factory NewWorksheetState.fromJson(Map<String, dynamic> json) {
    return NewWorksheetState(
      room: json['room'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      userId: json['userId'],
      technicianItems: (json['technicianItems'] as List?)
              ?.map((item) => TechnicianItem.fromJson(item))
              .toList() ??
          [],
      softwareItems: (json['softwareItems'] as List?)
              ?.map((item) => SoftwareItem.fromJson(item))
              .toList() ??
          [],
      hardwareItems: (json['hardwareItems'] as List?)
              ?.map((item) => HardwareItem.fromJson(item))
              .toList() ??
          [],
      networkItems: (json['networkItems'] as List?)
              ?.map((item) => NetworkItem.fromJson(item))
              .toList() ??
          [],
    );
  }

  static List<NewWorksheetState> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => NewWorksheetState.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'room': room,
      'startTime': startTime,
      'endTime': endTime,
      'userId': userId,
      'technicianItems': technicianItems.map((item) => item.toJson()).toList(),
      'softwareItems': softwareItems.map((item) => item.toJson()).toList(),
      'hardwareItems': hardwareItems.map((item) => item.toJson()).toList(),
      'networkItems': networkItems.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'NewWorksheetState(room: $room, startTime: $startTime, endTime: $endTime, userId: $userId, technicianItems: $technicianItems, softwareItems: $softwareItems, hardwareItems: $hardwareItems, networkItems: $networkItems)';
  }
}

class TechnicianItem {
  final int? id;

  TechnicianItem({required this.id});

  factory TechnicianItem.fromJson(Map<String, dynamic> json) {
    return TechnicianItem(id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }

  @override
  String toString() {
    return 'TechnicianItem(id: $id)';
  }
}

class SoftwareItem {
  final String? description;

  SoftwareItem({required this.description});

  factory SoftwareItem.fromJson(Map<String, dynamic> json) {
    return SoftwareItem(description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {'description': description};
  }

  @override
  String toString() {
    return 'SoftwareItem(description: $description)';
  }
}

class HardwareItem {
  final String? description;

  HardwareItem({required this.description});

  factory HardwareItem.fromJson(Map<String, dynamic> json) {
    return HardwareItem(description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {'description': description};
  }

  @override
  String toString() {
    return 'HardwareItem(description: $description)';
  }
}

class NetworkItem {
  final String? description;

  NetworkItem({required this.description});

  factory NetworkItem.fromJson(Map<String, dynamic> json) {
    return NetworkItem(description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {'description': description};
  }

  @override
  String toString() {
    return 'NetworkItem(description: $description)';
  }
}

class SingleWorksheetState {
  final WorksheetState worksheet;
  final List<Technician> technicians;
  final List<SoftwareItem> softwares;
  final List<HardwareItem> hardwares;
  final List<NetworkItem> networks;

  SingleWorksheetState({
    required this.worksheet,
    required this.technicians,
    required this.softwares,
    required this.hardwares,
    required this.networks,
  });

  factory SingleWorksheetState.fromJson(Map<String, dynamic> json) {
    return SingleWorksheetState(
      worksheet: WorksheetState.fromJson(json['worksheet']),
      technicians: (json['technicians'] as List?)
              ?.map((item) => Technician.fromJson(item))
              .toList() ??
          [],
      softwares: (json['softwares'] as List?)
              ?.map((item) => SoftwareItem.fromJson(item))
              .toList() ??
          [],
      hardwares: (json['hardwares'] as List?)
              ?.map((item) => HardwareItem.fromJson(item))
              .toList() ??
          [],
      networks: (json['networks'] as List?)
              ?.map((item) => NetworkItem.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'worksheet': worksheet.toString(),
      'technicians': technicians.map((tech) => tech.toJson()).toList(),
      'softwares': softwares.map((software) => software.toJson()).toList(),
      'hardwares': hardwares.map((hardware) => hardware.toJson()).toList(),
      'networks': networks.map((network) => network.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'SingleWorksheetState(worksheet: $worksheet, technicians: $technicians, softwares: $softwares, hardwares: $hardwares, networks: $networks)';
  }
}

class GetSingleWorksheetState {
  final int id;
  final String worksheetNumber;
  final String room;
  final String startTime;
  final String endTime;
  final int userId;
  final String createdAt;
  final String updatedAt;
  final List<TechnicianItem> technicians;
  final List<SoftwareItem> softwares;
  final List<HardwareItem> hardwares;
  final List<NetworkItem> networks;

  GetSingleWorksheetState({
    required this.id,
    required this.worksheetNumber,
    required this.room,
    required this.startTime,
    required this.endTime,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.technicians,
    required this.softwares,
    required this.hardwares,
    required this.networks,
  });

  factory GetSingleWorksheetState.fromJson(Map<String, dynamic> json) {
    return GetSingleWorksheetState(
      id: json['id'] ?? 0,
      worksheetNumber: json['worksheetNumber'] ?? '',
      room: json['room'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      userId: json['userId'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      technicians: (json['technicians'] as List?)
              ?.map(
                  (tech) => tech != null ? TechnicianItem.fromJson(tech) : null)
              .where((item) => item != null)
              .cast<TechnicianItem>()
              .toList() ??
          [],
      softwares: (json['softwares'] as List?)
              ?.map((item) => item != null ? SoftwareItem.fromJson(item) : null)
              .where((item) => item != null)
              .cast<SoftwareItem>()
              .toList() ??
          [],
      hardwares: (json['hardwares'] as List?)
              ?.map((item) => item != null ? HardwareItem.fromJson(item) : null)
              .where((item) => item != null)
              .cast<HardwareItem>()
              .toList() ??
          [],
      networks: (json['networks'] as List?)
              ?.map((item) => item != null ? NetworkItem.fromJson(item) : null)
              .where((item) => item != null)
              .cast<NetworkItem>()
              .toList() ??
          [],
    );
  }

  @override
  String toString() {
    return 'GetSingleWorksheetState(id: $id, worksheetNumber: $worksheetNumber, room: $room, startTime: $startTime, endTime: $endTime, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt, technicians: $technicians, softwares: $softwares, hardwares: $hardwares, networks: $networks)';
  }
}
