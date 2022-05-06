import 'package:auto_route/auto_route.dart';
import 'package:caption_this/Features/main_map/bloc/place_marker_bloc/bloc/place_marker_bloc.dart';
import 'package:caption_this/Features/main_map/presentation/main_map_page.dart';
import 'package:caption_this/Features/search/bloC/bloc/place_bloc.dart';
import 'package:caption_this/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/bloc_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/place_repository.dart';
import 'package:flutter/material.dart';
import 'package:caption_this/routes/router.gr.dart';
import "package:caption_this/core/widgets/nav_drawer.dart";

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.replay_outlined),
            onPressed: () {
              BlocProvider.of<PlaceMarkerBloc>(context).add(
                PlaceMarkerEventFetch(),
              );
            },
          ),
        ],
      ),
      body: MainMapPage(),
    );
  }
}
