import 'package:caption_this/Features/search/domain/entities/place_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';

class PlaceMarker extends StatelessWidget {
  final PlaceInfo place;
  const PlaceMarker({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String svgCode =
        '<svg width="65" height="107" fill="none" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">\n' +
            '<path d="M65 32.5C65 50.4493 49 90.5 32.5 107C16.5 91 0 50.4493 0 32.5C0 14.5507 14.5507 0 32.5 0C50.4493 0 65 14.5507 65 32.5Z" fill="#ffffff"/>\n' +
            '</svg>';

    final Widget svgIcon = SvgPicture.string(
      svgCode,
      semanticsLabel: 'A red up arrow',
      fit: BoxFit.contain,
      color: Color.fromARGB(255, 61, 200, 66),
    );

    return Container(
      transform: Matrix4.translationValues(8.7, 5, 0),
      width: 47,
      height: 47,
      child: const CircleAvatar(
        backgroundImage: NetworkImage(
            'https://www.iris-interactive.fr/wp-content/uploads/2015/09/insa.jpg',
            scale: 1.5),
      ),
    );
    Stack(
      children: [
        svgIcon,
        Container(
          transform: Matrix4.translationValues(8.7, 5, 0),
          width: 47,
          height: 47,
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://www.iris-interactive.fr/wp-content/uploads/2015/09/insa.jpg',
                scale: 1.5),
          ),
        ),
      ],
    );
  }
}
