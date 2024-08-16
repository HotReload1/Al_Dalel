import 'package:al_dalel/layers/bloc/chatbot/chatbot_cubit.dart';
import 'package:al_dalel/layers/bloc/government_building/government_building_cubit.dart';
import 'package:al_dalel/layers/bloc/places/places_cubit.dart';
import 'package:al_dalel/layers/bloc/recommendations/recommendations_cubit.dart';
import 'package:al_dalel/layers/data/data_provider/chatbot_provider.dart';
import 'package:al_dalel/layers/data/data_provider/location_provider.dart';
import 'package:al_dalel/layers/data/data_provider/places_provider.dart';
import 'package:al_dalel/layers/data/data_provider/recommendations_provider.dart';
import 'package:al_dalel/layers/data/repository/chatbot_repository.dart';
import 'package:al_dalel/layers/data/repository/location_repository.dart';
import 'package:al_dalel/layers/data/repository/places_repository.dart';
import 'package:al_dalel/layers/data/repository/recommendations_repository.dart';
import 'package:get_it/get_it.dart';

import 'core/dio/factory.dart';
import 'layers/bloc/bus_stop/bus_stop_cubit.dart';

final sl = GetIt.instance;

void initInjection() {
  sl.registerLazySingleton(() => DioFactory.create());

  //cubit
  sl.registerLazySingleton(() => RecommendationsCubit());
  sl.registerLazySingleton(() => PlacesCubit());
  sl.registerLazySingleton(() => ChatBotCubit());
  sl.registerLazySingleton(() => BusStopCubit());
  sl.registerLazySingleton(() => GovernmentBuildingCubit());

  //Provider

  //data_provider
  sl.registerLazySingleton(() => RecommendationsProvider());
  sl.registerLazySingleton(() => PlacesProvider());
  sl.registerLazySingleton(() => ChatBotProvider());
  sl.registerLazySingleton(() => LocationProvider());

  //repos
  sl.registerLazySingleton(() => RecommendationsRepository(sl()));
  sl.registerLazySingleton(() => PlacesRepository(sl()));
  sl.registerLazySingleton(() => ChatBotRepository(sl()));
  sl.registerLazySingleton(() => LocationRepository(sl()));
}
