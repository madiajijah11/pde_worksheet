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
}
