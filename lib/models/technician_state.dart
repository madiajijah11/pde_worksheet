class TechnicianState {
  final int id;
  final String username;
  final String name;
  final String titles;
  final String degrees;
  final bool isTechnician;

  TechnicianState({
    required this.id,
    required this.username,
    required this.name,
    required this.titles,
    required this.degrees,
    required this.isTechnician,
  });

  factory TechnicianState.fromJson(Map<String, dynamic> json) {
    return TechnicianState(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      titles: json['titles'],
      degrees: json['degrees'],
      isTechnician: json['isTechnician'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'titles': titles,
      'degrees': degrees,
      'isTechnician': isTechnician,
    };
  }

  @override
  String toString() {
    return 'TechnicianState{id: $id, username: $username, name: $name, titles: $titles, degrees: $degrees, isTechnician: $isTechnician}';
  }
}
