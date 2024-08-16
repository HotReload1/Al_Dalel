part of 'government_building_cubit.dart';

@immutable
abstract class GovernmentBuildingState extends Equatable{}

class GovernmentBuildingInitial extends GovernmentBuildingState {
  @override
  List<Object?> get props => [];
}

class GovernmentBuildingLoading extends GovernmentBuildingState {
  @override
  List<Object?> get props => [];
}

class GovernmentBuildingLoaded extends GovernmentBuildingState {
  final NearestBuilding nearestBuilding;

  GovernmentBuildingLoaded({required this.nearestBuilding});

  @override
  List<Object?> get props => [this.nearestBuilding];
}

class GovernmentBuildingError extends GovernmentBuildingState {
  final String error;

  GovernmentBuildingError({required this.error});

  @override
  List<Object?> get props => [this.error];
}
