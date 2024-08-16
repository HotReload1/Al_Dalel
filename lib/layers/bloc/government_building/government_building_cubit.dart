import 'package:al_dalel/layers/data/model/nearest_building.dart';
import 'package:al_dalel/layers/data/params/government_building_params.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../injection_container.dart';
import '../../data/repository/location_repository.dart';

part 'government_building_state.dart';

class GovernmentBuildingCubit extends Cubit<GovernmentBuildingState> {
  GovernmentBuildingCubit() : super(GovernmentBuildingInitial());

  LocationRepository _locationRepository = sl<LocationRepository>();

  void getGovernmentBuilding(
      double latitude, longitude, String services) async {
    emit(GovernmentBuildingLoading());
    final res = await _locationRepository.findNearestBuilding(
        GovernmentBuildingParams(
            body: GovernmentBuildingBody(
                latitude: latitude, longitude: longitude, services: services)));
    emit(res.fold((l) => GovernmentBuildingError(error: l.data!),
        (r) => GovernmentBuildingLoaded(nearestBuilding: r)));
  }
}
