class TechnicianState {
  final int id;
  final String username;
  final String name;
  final String? titles;
  final String? degrees;
  final String fullName;
  final bool isTechnician;

  TechnicianState({
    required this.id,
    required this.username,
    required this.name,
    this.titles,
    this.degrees,
    required this.fullName,
    required this.isTechnician,
  });

  factory TechnicianState.fromJson(Map<String, dynamic> json) {
    return TechnicianState(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      titles: json['titles'],
      degrees: json['degrees'],
      fullName:
          '${json['titles'] ?? ''} ${json['name']} ${json['degrees'] ?? ''}'
              .trim(),
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
      'fullName': fullName,
      'isTechnician': isTechnician,
    };
  }

  @override
  String toString() {
    return 'TechnicianState{id: $id, username: $username, name: $name, titles: $titles, degrees: $degrees, fullName: $fullName, isTechnician: $isTechnician}';
  }
}
