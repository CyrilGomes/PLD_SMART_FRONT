import 'package:auto_route/auto_route.dart';
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
            icon: const Icon(Icons.map),
            onPressed: () {
              context.router.push(MainMapRoute());
            },
          ),
        ],
      ),
      body: const PlaceDetailsWidget(),
    );
  }
}

class PlaceDetailsWidget extends StatefulWidget {
  const PlaceDetailsWidget({Key? key}) : super(key: key);

  @override
  State<PlaceDetailsWidget> createState() => _PlaceDetailsWidgetState();
}

class _PlaceDetailsWidgetState extends State<PlaceDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),

        child: ListView(
          children: [



                  Image.asset(
                    'res/images/bmc.jpg',
                    width: 600,
                    height: 240,
                    fit: BoxFit.cover,
                  ),
                  titleSection,
                  textSection,
                ],
            ),
        );
  }
}
Widget titleSection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        /*1*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*2*/
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: const Text(
                'Place Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Created By: ',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
      /*3*/
      Icon(
        Icons.star,
        color: Colors.red[500],
      ),
      const Text('Number of Likes'),
    ],
  ),
);

Widget textSection = const Padding(
  padding: EdgeInsets.all(32),
  child: Text(
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.' ,
    softWrap: true,
  ),
);
