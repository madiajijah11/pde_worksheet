class AuthState {
  final String? token;

  AuthState({this.token});

  AuthState copyWith({String? token}) {
    return AuthState(
      token: token ?? this.token,
    );
  }

  factory AuthState.fromJson(Map<String, dynamic> json) {
    return AuthState(
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }

  @override
  String toString() {
    return 'AuthState(token: $token)';
  }
}
