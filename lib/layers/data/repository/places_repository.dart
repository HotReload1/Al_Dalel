import 'package:al_dalel/layers/data/data_provider/places_provider.dart';
import 'package:al_dalel/layers/data/data_provider/recommendations_provider.dart';
import 'package:al_dalel/layers/data/model/place.dart';
import 'package:al_dalel/layers/data/model/recommend_place.dart';
import 'package:al_dalel/layers/data/params/get_places.dart';
import 'package:dartz/dartz.dart';
import '../../../core/exception/app_exception.dart';
import '../params/get_recommendations.dart';

class PlacesRepository {
  final PlacesProvider _placesProvider;

  PlacesRepository(this._placesProvider);

  Future<Either<AppException, List<Place>>> getPlaces(
      GetPlacesParams model) async {
    try {
      final res = await _placesProvider.getPlaces(model);
      List<Place> places = getPlacesList(res);
      return Right(places);
    } on AppException catch (e) {
      return Left(e);
    }
  }
}
