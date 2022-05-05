import 'package:caption_this/Features/search/domain/entities/place_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';

class PlaceMarker extends StatelessWidget {
  final PlaceInfo place;
  const PlaceMarker({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String svgCode =
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 107.1 154.53"><title>Asset 1</title><g id="Layer_2" data-name="Layer 2"><g id="Layer_1-2" data-name="Layer 1"><path d="M107.1,53.55c0,24.18-35.81,79.23-48.86,98.49a5.66,5.66,0,0,1-9.38,0C35.81,132.78,0,77.73,0,53.55a53.55,53.55,0,0,1,107.1,0Z" fill="#e6e6e6"/></g></g></svg>';

    final Widget svgIcon = SvgPicture.string(
      svgCode,
      semanticsLabel: 'A red up arrow',
      fit: BoxFit.contain,
      color: place.visited ? Colors.green : Colors.grey,
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        svgIcon,
        Container(
          transform: Matrix4.translationValues(0, -13, 0),
          child: const CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(
              'https://www.iris-interactive.fr/wp-content/uploads/2015/09/insa.jpg',
            ),
          ),
        ),
      ],
    );
  }
}
