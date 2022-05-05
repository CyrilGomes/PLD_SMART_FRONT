import 'package:auto_route/auto_route.dart';
import 'package:caption_this/Features/main_map/presentation/main_map_page.dart';
import 'package:caption_this/Features/search/bloC/bloc/place_bloc.dart';
import 'package:caption_this/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/bloc_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/place_repository.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home Page'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
            context.router.push(MainMapRoute());
            },
          ),
        ],
      ),
      body: const MyStatefulHomeWidget(),
    );
  }
}

class MyStatefulHomeWidget extends StatefulWidget {
  const MyStatefulHomeWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulHomeWidget> createState() => _MyStatefulHomeWidgetState();
}

class _MyStatefulHomeWidgetState extends State<MyStatefulHomeWidget> {
  final PlaceRepository placeRepository;
  final placeBloc= PlaceBloc(placeRepository);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),

        child: BlocBuilder (
          bloc:placeBloc,
          builder: (BuildContext context, PlaceState state){

            return Container();
          },
        ),


        );
  }
}

