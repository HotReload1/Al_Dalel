part of 'recommendations_cubit.dart';

@immutable
abstract class RecommendationsState extends Equatable {}

class RecommendationsInitial extends RecommendationsState {
  @override
  List<Object?> get props => [];
}

class RecommendationsLoading extends RecommendationsState {
  @override
  List<Object?> get props => [];
}

class RecommendationsLoaded extends RecommendationsState {
  final List<RecommendPlace> recommendPlaces;

  RecommendationsLoaded({required this.recommendPlaces});

  @override
  List<Object?> get props => [this.recommendPlaces];
}

class RecommendationsError extends RecommendationsState {
  final String error;

  RecommendationsError({required this.error});

  @override
  List<Object?> get props => [this.error];
}
