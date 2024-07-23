import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:pde_worksheet/src/worksheet/create_worksheet_view.dart';
import 'package:pde_worksheet/src/settings/settings_controller.dart';
import 'package:pde_worksheet/src/settings/settings_view.dart';
import 'package:pde_worksheet/src/login/login_view.dart';
import 'package:pde_worksheet/src/home/home_view.dart';
import 'package:pde_worksheet/store/store.dart';

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
            GlobalCupertinoLocalizations.delegate, // Corrected spelling
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
    // Adjusted for synchronous operation with FutureBuilder
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) {
        return FutureBuilder<String?>(
          future: SecureStorage.read("flutter.token"),
          builder: (context, snapshot) {
            final String? token = snapshot.data;

            print(token);

            // Define the routes that require authentication
            const List<String> protectedRoutes = [
              HomeView.routeName,
              CreateWorksheetView.routeName,
              // Add other protected route names here
            ];

            // Check if the requested route is protected and the user is not authenticated
            if (protectedRoutes.contains(settings.name) && token == null) {
              // Redirect to the LoginView
              return const LoginView();
            }

            // Existing route generation logic
            switch (settings.name) {
              case SettingsView.routeName:
                return SettingsView(controller: settingsController);
              case LoginView.routeName:
                return const LoginView();
              case HomeView.routeName:
                return const HomeView();
              case CreateWorksheetView.routeName:
                return const CreateWorksheetView();
              default:
                // Handle undefined routes
                return Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                );
            }
          },
        );
      },
    );
  }
}
