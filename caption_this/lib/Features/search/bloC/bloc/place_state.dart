part of 'place_bloc.dart';

@immutable
abstract class PlaceState {}

class PlaceInfoInitial extends PlaceState {}

class PlaceInfoLoading extends PlaceState {}

//PlaceInfoEvent will hold the data of place obj
class PlaceInfoLoadedSuccess extends PlaceState {
  //final PlaceInfo place;
  final PlaceInfo place;
  PlaceInfoLoadedSuccess({required this.place});
}

class PlaceInfoLoadedError extends PlaceState {
  final String message;
  PlaceInfoLoadedError({required this.message});
}

class PlaceInfoAdding extends PlaceState {}

class PlaceInfoAddedSuccess extends PlaceState {}

class PlaceInfoAddedError extends PlaceState {
  final String message;
  PlaceInfoAddedError({required this.message});
}
