import 'package:al_dalel/layers/data/model/place.dart';
import 'package:al_dalel/layers/data/model/service.dart';
import 'package:al_dalel/layers/data/params/get_places.dart';
import 'package:al_dalel/layers/data/repository/places_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../injection_container.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  PlacesCubit() : super(PlacesInitial());

  PlacesRepository _placesRepository =
  sl<PlacesRepository>();

  void getPlaces(Service service) async {
    emit(PlacesLoading());
    final res = await _placesRepository
        .getPlaces(GetPlacesParams(endPoint: service.endPoint));
    emit(res.fold((l) => PlacesError(error: l.data!),
            (r) => PlacesLoaded(places: r)));
  }
}
