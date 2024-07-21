class Worksheet {
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

  Worksheet({
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

  factory Worksheet.fromJson(Map<String, dynamic> json) {
    return Worksheet(
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

final List<Map<String, dynamic>> worksheetsData = [
  {
    "id": 1,
    "worksheetNumber": "1",
    "room": "Sakura",
    "startTime": "2024-07-01T11:37:56.000Z",
    "endTime": "2024-07-01T11:37:56.000Z",
    "userId": 2,
    "createdAt": "2024-07-02T05:31:07.583Z",
    "updatedAt": "2024-07-02T05:31:07.583Z",
    "technicians": [
      {"id": 1, "titles": null, "name": "Dian Rahmadani", "degrees": null}
    ],
    "softwares": [
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
    "hardwares": [
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
    "networks": [
      {"name": "Hub", "description": "No Internet", "result": "Change Route"},
      {"name": "Router", "description": "No Internet", "result": "Change Route"}
    ]
  },
  {
    "id": 2,
    "worksheetNumber": "2",
    "room": "Sakura",
    "startTime": "2024-07-01T11:37:56.000Z",
    "endTime": "2024-07-01T11:37:56.000Z",
    "userId": 2,
    "createdAt": "2024-07-10T03:30:01.730Z",
    "updatedAt": "2024-07-10T03:30:01.730Z",
    "technicians": [
      {"id": 1, "titles": null, "name": "Dian Rahmadani", "degrees": null},
      {"id": 2, "titles": "", "name": "Aldhy Friyanto", "degrees": "S.Kom"}
    ],
    "softwares": [
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
    "hardwares": [
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
    "networks": [
      {"name": "Hub", "description": "No Internet", "result": "Change Route"},
      {"name": "Router", "description": "No Internet", "result": "Change Route"}
    ]
  }
];
