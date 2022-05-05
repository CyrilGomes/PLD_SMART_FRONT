import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/repositories/place_repository.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceRepository placeRepository;

   PlaceBloc({ required this.placeRepository}) : super(PlaceInfo()) {
    on<PlaceInfoEvent>(_PlaceEvent);

  }

  _PlaceEvent(PlaceInfoEvent event, Emitter<PlaceState> emit) async {
    emit(PlaceInfoLoading());
    await placeRepository
        .getPlaceInfo(event.id)
        .then((res) {
      emit(PlaceInfoLoadedSuccess(info:res));

      // if (res != null) {
      //  print it out
      // }
    }).catchError((error) {
      emit(PlaceInfoLoadedError(message: error.toString()));
    });
  }
