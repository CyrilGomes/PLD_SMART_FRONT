import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:location/location.dart';

class MainMapPage extends StatefulWidget {
  MainMapPage({Key? key}) : super(key: key);

  @override
  State<MainMapPage> createState() => _MainMapPageState();
}

class _MainMapPageState extends State<MainMapPage> {
  latLng.LatLng _currentPosition = latLng.LatLng(0, 0);
  late CenterOnLocationUpdate _centerOnLocationUpdate;
  late StreamController<double?> _centerCurrentLocationStreamController;
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
    checkPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        zoom: 13,
        onPositionChanged: (MapPosition position, bool hasGesture) {
          if (hasGesture) {
            setState(
              () => _centerOnLocationUpdate = CenterOnLocationUpdate.never,
            );
          }
        },
      ),
      // ignore: sort_child_properties_last
      children: [
        TileLayerWidget(
          options: TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
            maxZoom: 19,
          ),
        ),
        LocationMarkerLayerWidget(
          plugin: LocationMarkerPlugin(
            centerCurrentLocationStream:
                _centerCurrentLocationStreamController.stream,
            centerOnLocationUpdate: _centerOnLocationUpdate,
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
        )
      ],
    );
  }
}
