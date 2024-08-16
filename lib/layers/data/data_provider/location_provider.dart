import 'package:al_dalel/layers/data/params/bus_stop_params.dart';
import 'package:al_dalel/layers/data/params/government_building_params.dart';
import '../../../core/data/data_provider.dart';

class LocationProvider extends RemoteDataSource {
  Future<dynamic> getBusStop(BusStopParams model) async {
    final res = await post(model);
    return Future.value(res);
  }

  Future<dynamic> getGovernmentBuilding(GovernmentBuildingParams model) async {
    final res = await post(model);
    return Future.value(res);
  }
}
