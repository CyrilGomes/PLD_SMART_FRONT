// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../Features/login/presentation/pages/login_page.dart' as _i1;
import '../Features/password_reset/presentation/pages/password_reset_page.dart'
    as _i3;
import '../Features/sign_up/presentation/pages/sign_up_page.dart' as _i2;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    LoginPageRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.LoginPage());
    },
    SignUpPageRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.SignUpPage());
    },
    PasswordResetPageRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.PasswordResetPage());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(LoginPageRoute.name, path: '/'),
        _i4.RouteConfig(SignUpPageRoute.name, path: '/sign-up-page'),
        _i4.RouteConfig(PasswordResetPageRoute.name,
            path: '/password-reset-page')
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginPageRoute extends _i4.PageRouteInfo<void> {
  const LoginPageRoute() : super(LoginPageRoute.name, path: '/');

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i2.SignUpPage]
class SignUpPageRoute extends _i4.PageRouteInfo<void> {
  const SignUpPageRoute() : super(SignUpPageRoute.name, path: '/sign-up-page');

  static const String name = 'SignUpPageRoute';
}

/// generated route for
/// [_i3.PasswordResetPage]
class PasswordResetPageRoute extends _i4.PageRouteInfo<void> {
  const PasswordResetPageRoute()
      : super(PasswordResetPageRoute.name, path: '/password-reset-page');

  static const String name = 'PasswordResetPageRoute';
}
