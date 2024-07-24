class WorksheetState {
  final int id;
  final String worksheetNumber;
  final String room;
  final String startTime;
  final String endTime;
  final int userId;
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
    return 'WorksheetState(id: $id, worksheetNumber: $worksheetNumber, room: $room, startTime: $startTime, endTime: $endTime, userId: $userId, technicians: $technicians, softwares: $softwares, hardwares: $hardwares, networks: $networks)';
  }
}

class Technician {
  final int id;
  final String? titles;
  final String name;
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

  String get fullName {
    return '${titles ?? ''} $name ${degrees ?? ''}'.trim();
  }

  @override
  String toString() {
    return 'Technician(id: $id, titles: $titles, name: $name, degrees: $degrees)';
  }
}

class Software {
  final String name;
  final String description;
  final String result;

  Software({
    required this.name,
    required this.description,
    required this.result,
  });

  factory Software.fromJson(Map<String, dynamic> json) {
    return Software(
      name: json['name'],
      description: json['description'],
      result: json['result'],
    );
  }

  @override
  String toString() {
    return 'Software(name: $name, description: $description, result: $result)';
  }
}

class Hardware {
  final String name;
  final String description;
  final String result;

  Hardware({
    required this.name,
    required this.description,
    required this.result,
  });

  factory Hardware.fromJson(Map<String, dynamic> json) {
    return Hardware(
      name: json['name'],
      description: json['description'],
      result: json['result'],
    );
  }

  @override
  String toString() {
    return 'Hardware(name: $name, description: $description, result: $result)';
  }
}

class Network {
  final String name;
  final String description;
  final String result;

  Network({
    required this.name,
    required this.description,
    required this.result,
  });

  factory Network.fromJson(Map<String, dynamic> json) {
    return Network(
      name: json['name'],
      description: json['description'],
      result: json['result'],
    );
  }

  @override
  String toString() {
    return 'Network(name: $name, description: $description, result: $result)';
  }
}

class NewWorksheetState {
  final String worksheetNumber;
  final String room;
  final String startTime;
  final String endTime;
  final int userId;
  final List<TechnicianItem> technicianItems;
  final List<SoftwareItem> softwareItems;
  final List<HardwareItem> hardwareItems;
  final List<NetworkItem> networkItems;

  NewWorksheetState({
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

  factory NewWorksheetState.fromJson(Map<String, dynamic> json) {
    return NewWorksheetState(
      worksheetNumber: json['worksheetNumber'],
      room: json['room'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      userId: json['userId'],
      technicianItems: (json['technicianItems'] as List)
          .map((item) => TechnicianItem.fromJson(item))
          .toList(),
      softwareItems: (json['softwareItems'] as List)
          .map((item) => SoftwareItem.fromJson(item))
          .toList(),
      hardwareItems: (json['hardwareItems'] as List)
          .map((item) => HardwareItem.fromJson(item))
          .toList(),
      networkItems: (json['networkItems'] as List)
          .map((item) => NetworkItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'worksheetNumber': worksheetNumber,
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
    return 'NewWorksheetState(worksheetNumber: $worksheetNumber, room: $room, startTime: $startTime, endTime: $endTime, userId: $userId, technicianItems: $technicianItems, softwareItems: $softwareItems, hardwareItems: $hardwareItems, networkItems: $networkItems)';
  }
}

class TechnicianItem {
  final String id;

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
  final String name;
  final String description;
  final String result;

  SoftwareItem(
      {required this.name, required this.description, required this.result});

  factory SoftwareItem.fromJson(Map<String, dynamic> json) {
    return SoftwareItem(
      name: json['name'],
      description: json['description'],
      result: json['result'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'result': result,
    };
  }

  @override
  String toString() {
    return 'SoftwareItem(name: $name, description: $description, result: $result)';
  }
}

class HardwareItem {
  final String name;
  final String description;
  final String result;

  HardwareItem(
      {required this.name, required this.description, required this.result});

  factory HardwareItem.fromJson(Map<String, dynamic> json) {
    return HardwareItem(
      name: json['name'],
      description: json['description'],
      result: json['result'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'result': result,
    };
  }

  @override
  String toString() {
    return 'HardwareItem(name: $name, description: $description, result: $result)';
  }
}

class NetworkItem {
  final String name;
  final String description;
  final String result;

  NetworkItem(
      {required this.name, required this.description, required this.result});

  factory NetworkItem.fromJson(Map<String, dynamic> json) {
    return NetworkItem(
      name: json['name'],
      description: json['description'],
      result: json['result'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'result': result,
    };
  }

  @override
  String toString() {
    return 'NetworkItem(name: $name, description: $description, result: $result)';
  }
}
