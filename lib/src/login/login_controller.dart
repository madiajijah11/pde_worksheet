import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';

import 'package:pde_worksheet/routes/app_router.gr.dart';
import 'package:pde_worksheet/services/auth_service.dart';

class LoginController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  Future<void> attemptLogin(BuildContext context, WidgetRef ref) async {
    if (formKey.currentState!.validate()) {
      try {
        await ref.read(authProvider.notifier).login(
              usernameController.text,
              passwordController.text,
            );
        final isAuthenticated = ref.read(authProvider).token != null;
        if (!context.mounted) return;
        if (isAuthenticated) {
          AutoRouter.of(context).replace(const HomeRoute());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid username or password'),
            ),
          );
        }
      } catch (e) {
        // Handle any exceptions that occur during the login attempt
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: $e'),
          ),
        );
      }
    }
  }
}
