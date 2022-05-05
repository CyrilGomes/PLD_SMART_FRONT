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

// required this.description,required this.name, required this.latitude,required this.longitude, required this.createdBy