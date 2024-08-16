import 'package:al_dalel/layers/data/data_provider/recommendations_provider.dart';
import 'package:al_dalel/layers/data/model/recommend_place.dart';
import 'package:dartz/dartz.dart';
import '../../../core/exception/app_exception.dart';
import '../params/get_recommendations.dart';

class RecommendationsRepository {
  final RecommendationsProvider _recommendationsProvider;

  RecommendationsRepository(this._recommendationsProvider);

  Future<Either<AppException, List<RecommendPlace>>> getRecommendations(
      GetRecommendationsParams model) async {
    try {
      final res = await _recommendationsProvider.getRecommendations(model);
      List<RecommendPlace> recommendPlaces = getRecommendPlacesList(res);
      return Right(recommendPlaces);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
