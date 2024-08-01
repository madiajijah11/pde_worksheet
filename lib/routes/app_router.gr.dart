// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:pde_worksheet/src/home/home_view.dart' as _i1;
import 'package:pde_worksheet/src/login/login_view.dart' as _i2;
import 'package:pde_worksheet/src/profile/profile_view.dart' as _i3;
import 'package:pde_worksheet/src/settings/settings_controller.dart' as _i8;
import 'package:pde_worksheet/src/settings/settings_view.dart' as _i4;
import 'package:pde_worksheet/src/worksheet/worksheet_view.dart' as _i5;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomeView(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginView(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.ProfileView(),
      );
    },
    SettingsRoute.name: (routeData) {
      final args = routeData.argsAs<SettingsRouteArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.SettingsView(
          key: args.key,
          controller: args.controller,
        ),
      );
    },
    WorksheetRoute.name: (routeData) {
      final args = routeData.argsAs<WorksheetRouteArgs>(
          orElse: () => const WorksheetRouteArgs());
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.WorksheetView(
          key: args.key,
          itemId: args.itemId,
          onWorksheetChanged: args.onWorksheetChanged,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.HomeView]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LoginView]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute(
      {List<_i6.PageRouteInfo>? children,
      required Future<Null> Function(dynamic result) onResult})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ProfileView]
class ProfileRoute extends _i6.PageRouteInfo<void> {
  const ProfileRoute({List<_i6.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SettingsView]
class SettingsRoute extends _i6.PageRouteInfo<SettingsRouteArgs> {
  SettingsRoute({
    _i7.Key? key,
    required _i8.SettingsController controller,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          SettingsRoute.name,
          args: SettingsRouteArgs(
            key: key,
            controller: controller,
          ),
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i6.PageInfo<SettingsRouteArgs> page =
      _i6.PageInfo<SettingsRouteArgs>(name);
}

class SettingsRouteArgs {
  const SettingsRouteArgs({
    this.key,
    required this.controller,
  });

  final _i7.Key? key;

  final _i8.SettingsController controller;

  @override
  String toString() {
    return 'SettingsRouteArgs{key: $key, controller: $controller}';
  }
}

/// generated route for
/// [_i5.WorksheetView]
class WorksheetRoute extends _i6.PageRouteInfo<WorksheetRouteArgs> {
  WorksheetRoute({
    _i7.Key? key,
    int? itemId,
    void Function()? onWorksheetChanged,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          WorksheetRoute.name,
          args: WorksheetRouteArgs(
            key: key,
            itemId: itemId,
            onWorksheetChanged: onWorksheetChanged,
          ),
          initialChildren: children,
        );

  static const String name = 'WorksheetRoute';

  static const _i6.PageInfo<WorksheetRouteArgs> page =
      _i6.PageInfo<WorksheetRouteArgs>(name);
}

class WorksheetRouteArgs {
  const WorksheetRouteArgs({
    this.key,
    this.itemId,
    this.onWorksheetChanged,
  });

  final _i7.Key? key;

  final int? itemId;

  final void Function()? onWorksheetChanged;

  @override
  String toString() {
    return 'WorksheetRouteArgs{key: $key, itemId: $itemId, onWorksheetChanged: $onWorksheetChanged}';
  }
}
