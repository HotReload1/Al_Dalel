import 'package:al_dalel/layers/data/model/recommend_place.dart';
import 'package:al_dalel/layers/data/params/get_recommendations.dart';
import 'package:al_dalel/layers/data/repository/recommendations_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../injection_container.dart';

part 'recommendations_state.dart';

class RecommendationsCubit extends Cubit<RecommendationsState> {
  RecommendationsCubit() : super(RecommendationsInitial());

  RecommendationsRepository _recommendationsRepository =
      sl<RecommendationsRepository>();

  void getRecommendations() async {
    emit(RecommendationsLoading());
    final res = await _recommendationsRepository
        .getRecommendations(GetRecommendationsParams());
    emit(res.fold((l) => RecommendationsError(error: l.data!),
        (r) => RecommendationsLoaded(recommendPlaces: r)));
  }
}
