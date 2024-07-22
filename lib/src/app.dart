import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:pde_worksheet/models/auth_state.dart';
import 'package:pde_worksheet/src/worksheet/create_worksheet_view.dart';
import 'package:pde_worksheet/src/settings/settings_controller.dart';
import 'package:pde_worksheet/src/settings/settings_view.dart';
import 'package:pde_worksheet/src/login/login_view.dart';
import 'package:pde_worksheet/src/home/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          onGenerateRoute: _generateRoute,
        );
      },
    );
  }

  Route<dynamic>? _generateRoute(RouteSettings settings) {
    // Assuming you have an AuthService that provides a method to check if the user is authenticated
    // This is a placeholder, replace with your actual authentication check logic
    final bool isAuthenticated = AuthState().isAuthenticated;

    // Define the routes that require authentication
    const List<String> protectedRoutes = [
      HomeView.routeName,
      CreateWorksheet.routeName,
      // Add other protected route names here
    ];

    // Check if the requested route is protected and the user is not authenticated
    if (protectedRoutes.contains(settings.name) && !isAuthenticated) {
      // Redirect to the LoginView
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => const LoginView(),
      );
    }

    // Existing route generation logic
    switch (settings.name) {
      case SettingsView.routeName:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) =>
              SettingsView(controller: settingsController),
        );
      case LoginView.routeName:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) => const LoginView(),
        );
      case HomeView.routeName:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) => const HomeView(),
        );
      case CreateWorksheet.routeName:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) => const CreateWorksheet(),
        );
      default:
        // Handle undefined routes
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
