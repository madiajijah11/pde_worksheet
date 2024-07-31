import 'package:flutter/material.dart';

import 'package:pde_worksheet/routes/app_router.dart';
import 'package:pde_worksheet/src/settings/settings_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = AppRouter();

    return ListenableBuilder(
        listenable: settingsController,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(),
            darkTheme: ThemeData.dark(),
            themeMode: settingsController.themeMode,
            routerConfig: appRouter.config(),
          );
        });
  }
}
