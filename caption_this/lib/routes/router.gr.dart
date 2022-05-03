// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../Features/auth/presentation/pages/login_page.dart' as _i2;
import '../Features/auth/presentation/pages/sign_up_page.dart' as _i3;
import '../Features/main_map/presentation/main_map_page.dart' as _i1;
import '../Features/password_reset/presentation/pages/password_reset_page.dart'
    as _i4;
import '../Features/search/presentation/pages/home_page.dart' as _i5;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    MainMapRoute.name: (routeData) {
      final args = routeData.argsAs<MainMapRouteArgs>(
          orElse: () => const MainMapRouteArgs());
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.MainMapPage(key: args.key));
    },
    LoginRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.LoginPage());
    },
    SignUpRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.SignUpPage());
    },
    PasswordResetRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.PasswordResetPage());
    },
    HomeRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.HomePage());
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(MainMapRoute.name, path: '/main-map-page'),
        _i6.RouteConfig(LoginRoute.name, path: '/'),
        _i6.RouteConfig(SignUpRoute.name, path: '/sign-up-page'),
        _i6.RouteConfig(PasswordResetRoute.name, path: '/password-reset-page'),
        _i6.RouteConfig(HomeRoute.name, path: '/home-page')
      ];
}

/// generated route for
/// [_i1.MainMapPage]
class MainMapRoute extends _i6.PageRouteInfo<MainMapRouteArgs> {
  MainMapRoute({_i7.Key? key})
      : super(MainMapRoute.name,
            path: '/main-map-page', args: MainMapRouteArgs(key: key));

  static const String name = 'MainMapRoute';
}

class MainMapRouteArgs {
  const MainMapRouteArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'MainMapRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.SignUpPage]
class SignUpRoute extends _i6.PageRouteInfo<void> {
  const SignUpRoute() : super(SignUpRoute.name, path: '/sign-up-page');

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [_i4.PasswordResetPage]
class PasswordResetRoute extends _i6.PageRouteInfo<void> {
  const PasswordResetRoute()
      : super(PasswordResetRoute.name, path: '/password-reset-page');

  static const String name = 'PasswordResetRoute';
}

/// generated route for
/// [_i5.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/home-page');

  static const String name = 'HomeRoute';
}
