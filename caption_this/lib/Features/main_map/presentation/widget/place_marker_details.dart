import 'package:caption_this/Features/main_map/bloc/place_marker_bloc/bloc/place_marker_bloc.dart';
import 'package:caption_this/Features/search/bloC/bloc/place_bloc.dart';
import 'package:caption_this/Features/search/domain/entities/place_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  Tween<double> opacityTween = Tween<double>(begin: 0.0, end: 1.0);
  Tween<double> marginTopTween = Tween<double>(begin: 600, end: 400);
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
            child: Column(children: [Text('${widget.place.name}')]),
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
