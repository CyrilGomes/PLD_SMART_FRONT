part of 'place_marker_bloc.dart';

@immutable
abstract class PlaceMarkerEvent {}

class PlaceMarkerEventFetch extends PlaceMarkerEvent {
  PlaceMarkerEventFetch();
}
