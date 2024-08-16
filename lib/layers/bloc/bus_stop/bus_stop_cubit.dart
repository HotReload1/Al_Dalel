import 'package:al_dalel/layers/data/model/bus_stop.dart';
import 'package:al_dalel/layers/data/params/bus_stop_params.dart';
import 'package:al_dalel/layers/data/repository/location_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../injection_container.dart';

part 'bus_stop_state.dart';

class BusStopCubit extends Cubit<BusStopState> {
  BusStopCubit() : super(BusStopInitial());

  LocationRepository _locationRepository = sl<LocationRepository>();

  void getBusStop(String location) async {
    if (location.trim().isEmpty) {
      emit(BusStopInitial());
      return;
    }
    emit(BusStopLoading());
    final res = await _locationRepository
        .getBusStop(BusStopParams(body: BusStopBody(location: location)));
    emit(res.fold((l) => BusStopError(error: l.data!),
        (r) => BusStopLoaded(busStops: r)));
  }
}
