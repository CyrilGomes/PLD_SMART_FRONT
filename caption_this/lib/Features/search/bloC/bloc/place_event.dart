part of 'place_bloc.dart';

@immutable
abstract class PlaceEvent {}

class PlaceInfoEvent extends PlaceEvent {
  final String id;
  // final String description; //length=1000
  // final String name;
  // //String image="";
  // final double latitude;
  // final double longitude;
  // final String createdBy;
  PlaceInfoEvent({required this.id});
}

class PlaceInfoAddEvent extends PlaceEvent {
  final PlaceInfo place;
  PlaceInfoAddEvent({required this.place});
}
