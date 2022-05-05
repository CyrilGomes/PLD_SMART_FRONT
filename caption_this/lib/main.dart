import 'package:caption_this/Features/auth/BloC/bloc/auth_bloc.dart';
import 'package:caption_this/Features/main_map/bloc/place_marker_bloc/bloc/place_marker_bloc.dart';
import 'package:caption_this/Features/search/bloC/bloc/place_bloc.dart';
import 'package:caption_this/Features/search/domain/repositories/place_repository.dart';
import 'package:caption_this/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Features/auth/domain/repositories/auth_repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(AuthRepository()),
        ),
        BlocProvider(
          create: (context) => PlaceMarkerBloc(PlaceRepository()),
        ),
        BlocProvider(
          create: (context) => PlaceBloc(PlaceRepository()),
        )
      ],
      child: MaterialApp.router(
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
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
