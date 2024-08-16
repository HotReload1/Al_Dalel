import 'package:al_dalel/layers/data/params/get_places.dart';
import '../../../core/data/data_provider.dart';

class PlacesProvider extends RemoteDataSource {
  Future<dynamic> getPlaces(GetPlacesParams model) async {
    final res = await get(model);
    return Future.value(res);
  }
}
