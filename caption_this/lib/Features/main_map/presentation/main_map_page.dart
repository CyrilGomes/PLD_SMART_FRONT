import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:caption_this/Features/main_map/bloc/place_marker_bloc/bloc/place_marker_bloc.dart';
import 'package:caption_this/Features/main_map/presentation/widget/place_marker_details.dart';
import 'package:caption_this/Features/search/bloC/bloc/place_bloc.dart';
import 'package:caption_this/Features/search/domain/entities/place_info.dart';
import 'package:caption_this/Features/search/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:location/location.dart';

import 'widget/place_marker.dart';

class MainMapPage extends StatefulWidget {
  MainMapPage({Key? key}) : super(key: key);

  @override
  State<MainMapPage> createState() => _MainMapPageState();
}

class _MainMapPageState extends State<MainMapPage>
    with TickerProviderStateMixin {
  late latLng.LatLng _currentPosition;
  late CenterOnLocationUpdate _centerOnLocationUpdate;
  late StreamController<double?> _centerCurrentLocationStreamController;
  late AnchorPos anchorPos;

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  Future<void> checkPermissions() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
  }

  final Location location = Location();
  final MapController _mapController = MapController();

  @override
  void dispose() {
    _centerCurrentLocationStreamController.close();
    super.dispose();
  }

  @override
  void initState() {
    _centerOnLocationUpdate = CenterOnLocationUpdate.always;
    _centerCurrentLocationStreamController = StreamController<double?>();

    super.initState();
  }

  void _animatedMapMove(latLng.LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final _latTween = Tween<double>(
        begin: _mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: _mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      _mapController.move(
          latLng.LatLng(
              _latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  void showPopup(PlaceInfo placeInfo) {
    AnimationController controller = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    BlocProvider.of<PlaceBloc>(context)
        .add(PlaceInfoEvent(id: placeInfo.id.toString()));
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      builder: (_) => BlocBuilder<PlaceBloc, PlaceState>(
        builder: (context, state) {
          if (state is PlaceInfoLoadedSuccess) {
            return PlaceMarkerDetails(
              place: state.place,
              controller: controller,
            );
          }
          return Container();
        },
      ),
    );
  }

  List<PlaceInfo> _places = [];
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  void checkNearPlace(MapPosition position) async {
    //loop over all places and check if they are near the current position
    for (var place in _places.where((element) => !element.visited)) {
      if (position.center != null) {
        var distanceCalculator = latLng.Distance();
        var distance = distanceCalculator.as(latLng.LengthUnit.Meter,
            position.center!, latLng.LatLng(place.latitude, place.longitude));
        print(
            'Longitude: ${position.center!.longitude} latitude: ${position.center!.latitude} place: ${place.latitude} ${place.longitude} distance: $distance');
        if (distance < 50 && !place.visited) {
          //get place marker bloc and update the state
          BlocProvider.of<PlaceMarkerBloc>(context).add(
            PlaceMarkerVisitEvent(id: place.id.toString()),
          );
          place.visited = true;
          setState(() {
            _places = _places;
          });
        }
      }
    }
  }

  void addPlaceMarker(PlaceInfo place) {
    setState(() {
      _places.add(place);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
          maxZoom: 19,
          interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
          zoom: 13,
          onPositionChanged: (MapPosition position, bool hasGesture) {
            _currentPosition = position.center!;
            checkNearPlace(position);
            if (hasGesture) {
              setState(
                () => _centerOnLocationUpdate = CenterOnLocationUpdate.never,
              );
            }
          },
          onMapCreated: (mapController) async {
            checkPermissions();

            BlocProvider.of<PlaceMarkerBloc>(context).add(
              PlaceMarkerEventFetch(),
            );
          }),
      // ignore: sort_child_properties_last
      children: [
        TileLayerWidget(
          options: TileLayerOptions(
              overrideTilesWhenUrlChanges: false,
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
              maxZoom: 19),
        ),
        LocationMarkerLayerWidget(
          plugin: LocationMarkerPlugin(
            centerCurrentLocationStream:
                _centerCurrentLocationStreamController.stream,
            centerOnLocationUpdate: _centerOnLocationUpdate,
          ),
        ),
        BlocListener<PlaceMarkerBloc, PlaceMarkerState>(
          listener: (context, state) {
            if (state is PlaceMarkerLoaded) {
              print("loaded markers");
              setState(() {
                _places = state.places;
              });
            }
            if (state is PlaceMarkerVisitedError) {
              _places
                  .where((element) => element.id.toString() == state.id)
                  .first
                  .visited = false;
              setState(() {
                _places = _places;
              });
            }
          },
          child: MarkerLayerWidget(
            options: MarkerLayerOptions(
              markers: _places
                  .map(
                    (place) => Marker(
                      width: 90,
                      height: 90,
                      anchorPos: AnchorPos.align(AnchorAlign.top),
                      point: latLng.LatLng(place.latitude, place.longitude),
                      builder: (context) => InkWell(
                        onTap: () {
                          _animatedMapMove(
                              latLng.LatLng(
                                  place.latitude - 0.0025, place.longitude),
                              16);
                          setState(
                            () => _centerOnLocationUpdate =
                                CenterOnLocationUpdate.never,
                          );
                          showPopup(place);
                        },
                        child: PlaceMarker(
                          place: place,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
      nonRotatedChildren: [
        Positioned(
          right: 20,
          bottom: 20,
          child: FloatingActionButton(
            onPressed: () {
              // Automatically center the location marker on the map when location updated until user interact with the map.
              setState(
                () => _centerOnLocationUpdate = CenterOnLocationUpdate.always,
              );
              // Center the location marker on the map and zoom the map to level 18.
              _centerCurrentLocationStreamController.add(18);
            },
            child: const Icon(
              Icons.my_location,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          left: 20,
          bottom: 20,
          child: FloatingActionButton(
            onPressed: () {
              //create a widget with a name input field a description input field and a submit button
              Widget inputFormWidget = Container(
                height: 250,
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: "Name",
                      ),
                    ),
                    TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: "Description",
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        PlaceInfo placeInfo = PlaceInfo.fromJson({
                          "id": 1,
                          "latitude": _currentPosition.longitude,
                          "longitude": _currentPosition.latitude,
                          "name": _nameController.text,
                          "description": _descriptionController.text,
                          "visited": false
                        });
                        BlocProvider.of<PlaceBloc>(context).add(
                          PlaceInfoAddEvent(place: placeInfo),
                        );

                        Navigator.pop(context);
                      },
                      child: Text("Submit"),
                    )
                  ],
                ),
              );

              showDialog(
                context: context,
                builder: (context) => Container(
                  child: AlertDialog(
                    title: Text("Add a place"),
                    content: inputFormWidget,
                  ),
                ),
              );
            },
            child: BlocConsumer<PlaceBloc, PlaceState>(
              listener: (context, state) {
                if (state is PlaceInfoAddedSuccess) {
                  BlocProvider.of<PlaceMarkerBloc>(context).add(
                    PlaceMarkerEventFetch(),
                  );
                  //show a snackbar to inform the user that the place has been added
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Place added"),
                    ),
                  );
                }
                if (state is PlaceInfoAddedError) {
                  //show a snackbar to inform the user that the place has been added
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Error place added"),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is PlaceInfoAdding) {
                  return const CircularProgressIndicator();
                }
                return const Icon(
                  Icons.add_location,
                  color: Colors.white,
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
