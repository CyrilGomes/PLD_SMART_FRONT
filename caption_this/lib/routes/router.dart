import 'package:auto_route/annotations.dart';
import 'package:caption_this/Features/auth/presentation/pages/login_page.dart';
import 'package:caption_this/Features/auth/presentation/pages/sign_up_page.dart';
import 'package:caption_this/Features/main_map/presentation/main_map_page.dart';
import 'package:caption_this/Features/search/presentation/pages/home_page.dart';
import 'package:caption_this/Features/password_reset/presentation/pages/password_reset_page.dart';
import 'package:caption_this/Features/search/presentation/pages/place_details_widget.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: MainMapPage),
    AutoRoute(page: LoginPage, initial: true),
    AutoRoute(page: SignUpPage),
    AutoRoute(page: PasswordResetPage),
    AutoRoute(page: HomePage),
    AutoRoute(page: CommentsPage)
  ],
)
class $AppRouter {}
