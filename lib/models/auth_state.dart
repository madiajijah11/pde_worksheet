class AuthState {
  final bool isAuthenticated;
  final String? token;

  AuthState({this.isAuthenticated = false, this.token});

  AuthState copyWith({bool? isAuthenticated, String? token}) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      token: token ?? this.token,
    );
  }
}
