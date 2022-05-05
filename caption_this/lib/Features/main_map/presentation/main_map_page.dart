import 'dart:async';

import 'package:caption_this/Features/main_map/bloc/place_marker_bloc/bloc/place_marker_bloc.dart';
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

class _MainMapPageState extends State<MainMapPage> {
  latLng.LatLng _currentPosition = latLng.LatLng(0, 0);
  late CenterOnLocationUpdate _centerOnLocationUpdate;
  late StreamController<double?> _centerCurrentLocationStreamController;
  late AnchorPos anchorPos;
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

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
          maxZoom: 19,
          interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
          zoom: 13,
          onPositionChanged: (MapPosition position, bool hasGesture) {
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
        BlocBuilder<PlaceMarkerBloc, PlaceMarkerState>(
          builder: (context, state) {
            if (state is PlaceMarkerLoaded) {
              return MarkerLayerWidget(
                options: MarkerLayerOptions(
                  markers: state.places
                      .map(
                        (place) => Marker(
                          width: 90,
                          height: 90,
                          anchorPos: AnchorPos.align(AnchorAlign.top),
                          point: latLng.LatLng(place.latitude, place.longitude),
                          builder: (context) => InkWell(
                            onTap: () {
                              //show snackbar
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(place.name ?? 'Unknown'),
                                ),
                              );
                            },
                            child: PlaceMarker(
                              place: place,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              );
            }
            return Container();
          },
        ),
      ],
      nonRotatedChildren: [
        Positioned(
          right: 20,
          bottom: 20,
          child: FloatingActionButton(
            onPressed: () {
              // Automatically center the location marker on the map when location updated until user interact with the map.
              BlocProvider.of<PlaceMarkerBloc>(context).add(
                PlaceMarkerEventFetch(),
              );
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
        )
      ],
    );
  }
}
