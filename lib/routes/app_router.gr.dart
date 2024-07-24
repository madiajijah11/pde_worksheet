// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:pde_worksheet/src/home/home_view.dart' as _i2;
import 'package:pde_worksheet/src/login/login_view.dart' as _i3;
import 'package:pde_worksheet/src/worksheet/create_worksheet_view.dart' as _i1;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    CreateWorksheetRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.CreateWorksheetView(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeView(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginView(),
      );
    },
  };
}

/// generated route for
/// [_i1.CreateWorksheetView]
class CreateWorksheetRoute extends _i4.PageRouteInfo<void> {
  const CreateWorksheetRoute({List<_i4.PageRouteInfo>? children})
      : super(
          CreateWorksheetRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateWorksheetRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeView]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginView]
class LoginRoute extends _i4.PageRouteInfo<void> {
  const LoginRoute(
      {List<_i4.PageRouteInfo>? children,
      required Future<Null> Function(dynamic result) onResult})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
