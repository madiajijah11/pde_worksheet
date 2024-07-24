class RoomState {
  final int id;
  final String name;

  RoomState({
    required this.id,
    required this.name,
  });

  factory RoomState.fromJson(Map<String, dynamic> json) {
    return RoomState(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'RoomState(id: $id, name: $name)';
  }
}
