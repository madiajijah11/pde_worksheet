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
}
