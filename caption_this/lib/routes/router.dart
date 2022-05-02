import 'package:auto_route/annotations.dart';
import 'package:caption_this/Features/auth/presentation/pages/login_page.dart';
import 'package:caption_this/Features/auth/presentation/pages/sign_up_page.dart';
import 'package:caption_this/Features/password_reset/presentation/pages/password_reset_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LoginPage, initial: true),
    AutoRoute(page: SignUpPage),
    AutoRoute(page: PasswordResetPage),
  ],
)
class $AppRouter {}
