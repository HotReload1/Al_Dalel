part of 'places_cubit.dart';

@immutable
abstract class PlacesState extends Equatable {}

class PlacesInitial extends PlacesState {
  @override
  List<Object?> get props => [];
}

class PlacesLoading extends PlacesState {
  @override
  List<Object?> get props => [];
}

class PlacesLoaded extends PlacesState {
  final List<Place> places;

  PlacesLoaded({required this.places});

  @override
  List<Object?> get props => [this.places];
}

class PlacesError extends PlacesState {
  final String error;

  PlacesError({required this.error});

  @override
  List<Object?> get props => [this.error];
}
