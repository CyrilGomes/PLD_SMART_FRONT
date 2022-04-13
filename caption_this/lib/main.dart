import 'package:caption_this/routes/router.gr.dart';
import 'package:flutter/material.dart';

import 'Features/login/presentation/pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
    // return MaterialApp(
    //   title: 'CaptionThis',
    //   theme: ThemeData(
    //     primaryColor: Colors.green.shade800,
    //
    //   ),
    //   home: const LoginPage(),
    // );
  }
}
