part of 'bus_stop_cubit.dart';

@immutable
abstract class BusStopState extends Equatable {}

class BusStopInitial extends BusStopState {
  @override
  List<Object?> get props => [];
}

class BusStopLoading extends BusStopState {
  @override
  List<Object?> get props => [];
}

class BusStopLoaded extends BusStopState {
  final List<BusStop> busStops;

  BusStopLoaded({required this.busStops});

  @override
  List<Object?> get props => [this.busStops];
}

class BusStopError extends BusStopState {
  final String error;

  BusStopError({required this.error});

  @override
  List<Object?> get props => [this.error];
}
