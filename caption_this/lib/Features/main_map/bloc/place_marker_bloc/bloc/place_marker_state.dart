part of 'place_marker_bloc.dart';

@immutable
abstract class PlaceMarkerState {}

class PlaceMarkerInitial extends PlaceMarkerState {}

class PlaceMarkerLoading extends PlaceMarkerState {}

class PlaceMarkerLoaded extends PlaceMarkerState {
  final List<PlaceInfo> places;

  PlaceMarkerLoaded({required this.places});
}

class PlaceMarkerError extends PlaceMarkerState {
  final String message;

  PlaceMarkerError({required this.message});
}
