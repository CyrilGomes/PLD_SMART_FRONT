part of 'place_bloc.dart';

@immutable
abstract class PlaceState {}

class InitialPlace extends PlaceState{}

class PlaceInfo extends PlaceState {
}

class PlaceInfoLoadedError extends PlaceState {
  final String message;
  PlaceInfoLoadedError({required this.message});
}
//PlaceInfoEvent will hold the data of place obj
class PlaceInfoLoadedSuccess extends PlaceState {

  //final PlaceInfo place;
  final String info;
  PlaceInfoLoadedSuccess({required this.info});

}
class PlaceInfoLoading extends PlaceState {
}
