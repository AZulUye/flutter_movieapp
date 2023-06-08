import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movieapp_propnextest_mzulkifly/data/api_service.dart';
import 'package:movieapp_propnextest_mzulkifly/provider/movie_detail.dart';

import 'package:movieapp_propnextest_mzulkifly/provider/movie_now_playing.dart';
import 'package:movieapp_propnextest_mzulkifly/provider/movie_search.dart';
import 'package:movieapp_propnextest_mzulkifly/provider/movie_popular.dart';

import 'repositories/movie_repository.dart';
import 'repositories/movie_repository_impl.dart';

final serviceLocator = GetIt.instance;

void serviceLocatorSetup() {
  // Register Provider
  serviceLocator.registerFactory<MoviePopularProvider>(
    () => MoviePopularProvider(serviceLocator()),
  );
  serviceLocator.registerFactory<MovieNowPlayingProvider>(
    () => MovieNowPlayingProvider(serviceLocator()),
  );
  serviceLocator.registerFactory<MovieDetailProvider>(
    () => MovieDetailProvider(serviceLocator()),
  );

  serviceLocator.registerFactory<MovieSearchProvider>(
    () => MovieSearchProvider(serviceLocator()),
  );

  // Register Repository
  serviceLocator.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(serviceLocator()));

  // Register Http Client (DIO)
  serviceLocator.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: ApiService.baseUrl,
        queryParameters: {'api_key': ApiService.apiKey},
      ),
    ),
  );
}
