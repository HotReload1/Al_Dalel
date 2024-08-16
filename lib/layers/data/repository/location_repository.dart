import 'package:al_dalel/layers/data/data_provider/chatbot_provider.dart';
import 'package:al_dalel/layers/data/data_provider/location_provider.dart';
import 'package:al_dalel/layers/data/model/bus_stop.dart';
import 'package:al_dalel/layers/data/model/nearest_building.dart';
import 'package:al_dalel/layers/data/params/bus_stop_params.dart';
import 'package:al_dalel/layers/data/params/government_building_params.dart';
import 'package:dartz/dartz.dart';
import '../../../core/exception/app_exception.dart';
import '../model/predicted_restaurant.dart';

class LocationRepository {
  final LocationProvider _locationProvider;

  LocationRepository(this._locationProvider);

  Future<Either<AppException, List<BusStop>>> getBusStop(
      BusStopParams model) async {
    try {
      final res = await _locationProvider.getBusStop(model);
      List<BusStop> busStop = getBusStopList(res);
      return Right(busStop);
    } on AppException catch (e) {
      return Left(e);
    }
  }

  Future<Either<AppException, NearestBuilding>> findNearestBuilding(
      GovernmentBuildingParams model) async {
    try {
      final res = await _locationProvider.getGovernmentBuilding(model);
      NearestBuilding nearestBuilding = NearestBuilding.fromJson(res);
      return Right(nearestBuilding);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
