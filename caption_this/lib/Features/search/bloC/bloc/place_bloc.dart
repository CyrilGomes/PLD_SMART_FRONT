import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:caption_this/Features/search/domain/entities/place_info.dart';
import '../../domain/repositories/place_repository.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceRepository _placeRepository;

  PlaceBloc(this._placeRepository) : super(PlaceInfoInitial()) {
    on<PlaceInfoEvent>(_PlaceEvent);
  }

  _PlaceEvent(PlaceInfoEvent event, Emitter<PlaceState> emit) async {
    emit(PlaceInfoLoading());
    try {
      var place = await _placeRepository.place(event.id);

      emit(PlaceInfoLoadedSuccess(place: place));

      // if (res != null) {
      //  print it out
      // }
    } catch (error) {
      print("PlaceInfoEvent: $error");
      emit(PlaceInfoLoadedError(message: error.toString()));
    }
  }
}
