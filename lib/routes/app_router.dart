import 'package:auto_route/auto_route.dart';
import 'package:pde_worksheet/routes/guard/auth_guard.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: HomeRoute.page, initial: true, guards: [AuthGuard()]),
        AutoRoute(page: CreateWorksheetRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: ProfileRoute.page, guards: [AuthGuard()]),
      ];
}
