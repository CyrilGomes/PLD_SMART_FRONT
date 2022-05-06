import 'package:auto_route/auto_route.dart';
import 'package:caption_this/Features/main_map/bloc/place_marker_bloc/bloc/place_marker_bloc.dart';
import 'package:caption_this/Features/search/bloC/bloc/place_bloc.dart';
import 'package:caption_this/Features/search/domain/entities/place_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../search/presentation/pages/home_page.dart';

class PlaceMarkerDetails extends StatefulWidget {
  final PlaceInfo place;
  const PlaceMarkerDetails(
      {Key? key, required this.controller, required this.place})
      : super(key: key);
  final AnimationController controller;
  @override
  State<PlaceMarkerDetails> createState() => _PlaceMarkerDetailsState();
}

class _PlaceMarkerDetailsState extends State<PlaceMarkerDetails> {
  late Animation<double> opacityAnimation;
  Tween<double> opacityTween = Tween<double>(begin: 0.0, end: 0.9);
  Tween<double> marginTopTween = Tween<double>(begin: 500, end: 450);
  late Animation<double> marginTopAnimation;
  late AnimationStatus animationStatus;
  @override
  void initState() {
    super.initState();

    marginTopAnimation = marginTopTween.animate(widget.controller)
      ..addListener(() {
        animationStatus = widget.controller.status;

        if (animationStatus == AnimationStatus.dismissed) {
          Navigator.of(context).pop();
        }

        if (this.mounted) {
          setState(() {});
        }
      });
    widget.controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacityTween.animate(widget.controller),
      child: GestureDetector(
        onTap: () {
          widget.controller.reverse();
        },
        child: Material(
          color: Colors.transparent,
          child: Container(
            color: Colors.white,
            margin: EdgeInsets.only(
              top: marginTopAnimation.value,
            ),
            child: Column(children: [
              Text(
                '${widget.place.name}',
                style: TextStyle(height: 2, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'res/images/bmc.jpg',
                width: 400,
                height: 200,
                fit: BoxFit.contain,
              ),
              new ButtonBar(
                mainAxisSize: MainAxisSize
                    .min, // this will take space as minimum as posible(to center)
                children: <Widget>[
                  new ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                    child: new Text('View Details'),
                    onPressed: null,
                  ),
                  new ElevatedButton(
                    child: new Text('     Cancel     '),
                    onPressed: null,
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}
