part of 'place_marker_bloc.dart';

@immutable
abstract class PlaceMarkerEvent {}

class PlaceMarkerEventFetch extends PlaceMarkerEvent {
  PlaceMarkerEventFetch();
}

class PlaceMarkerVisitEvent extends PlaceMarkerEvent {
  final String id;
  PlaceMarkerVisitEvent({required this.id});
}
