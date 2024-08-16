import 'package:al_dalel/layers/data/params/get_recommendations.dart';
import '../../../core/data/data_provider.dart';

class RecommendationsProvider extends RemoteDataSource {
  Future<dynamic> getRecommendations(GetRecommendationsParams model) async {
    final res = await get(model);
    return Future.value(res);
  }
}
