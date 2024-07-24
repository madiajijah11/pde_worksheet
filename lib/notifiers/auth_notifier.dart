import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pde_worksheet/models/auth_state.dart';
import 'package:pde_worksheet/services/auth_service.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  final AuthService _authService = AuthService();

  Future<void> login(String username, String password) async {
    final token = await _authService.login(username, password);
    if (token != null) {
      state = state.copyWith(token: token);
    }
  }
}
