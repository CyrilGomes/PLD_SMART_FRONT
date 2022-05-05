import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:caption_this/Features/search/domain/entities/place_info.dart';
import 'package:caption_this/Features/search/domain/repositories/place_repository.dart';
import 'package:meta/meta.dart';

part 'place_marker_event.dart';
part 'place_marker_state.dart';

class PlaceMarkerBloc extends Bloc<PlaceMarkerEvent, PlaceMarkerState> {
  PlaceRepository _placeRepository;

  PlaceMarkerBloc(this._placeRepository) : super(PlaceMarkerInitial()) {
    on<PlaceMarkerEventFetch>(_PlaceMarkerEventFetch);
    on<PlaceMarkerVisitEvent>(_PlaceMarkerVisitEvent);
  }

  _PlaceMarkerEventFetch(
      PlaceMarkerEventFetch event, Emitter<PlaceMarkerState> emit) async {
    emit(PlaceMarkerLoading());
    try {
      var places = await _placeRepository.getPlacesResumed();
      emit(PlaceMarkerLoaded(places: places));
    } catch (e) {
      emit(PlaceMarkerError(message: e.toString()));
    }
  }

  _PlaceMarkerVisitEvent(
      PlaceMarkerVisitEvent event, Emitter<PlaceMarkerState> emit) async {
    emit(PlaceMarkerVisitedLoading());
    try {
      var place = await _placeRepository.visitPlace(event.id);
      emit(PlaceMarkerVisited(place: place));
    } catch (e) {
      emit(PlaceMarkerVisitedError(id: event.id));
    }
  }
}
