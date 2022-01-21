import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/features/characters/data/datasources/characters_remote_data_source.dart';
import 'package:rick_and_morty/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/characters_repository.dart';
import 'package:rick_and_morty/features/characters/domain/use_cases/get_series.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters/characters_bloc.dart';

import 'features/characters/domain/use_cases/get_characters.dart';
import 'features/characters/domain/use_cases/get_concrete_character.dart';
import 'features/characters/presentation/bloc/character/character_bloc.dart';

import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

Future<void> init() async {
  // Features - Number Trivia
  initFeatures();
  // Core
  initCore();
  // External
  await initExternal();
}

void initFeatures() {
  // BLoC
  serviceLocator.registerFactory(() => CharactersBloc(
      getCharacters: serviceLocator(), getSeries: serviceLocator()));
  serviceLocator.registerFactory(
      () => CharacterBloc(getConcreteCharacter: serviceLocator()));

  // Use Cases
  serviceLocator.registerLazySingleton(() => GetCharacters(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => GetConcreteCharacter(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetSeries(serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<CharactersRepository>(
      () => CharactersRepositoryImpl(remoteDataSource: serviceLocator()));

  // Data sources
  serviceLocator.registerLazySingleton<CharactersRemoteDataSource>(
      () => CharactersRemoteDataSourceImpl(client: serviceLocator()));
}

void initCore() {
  // input converter
  // network info
}

Future<void> initExternal() async {
  serviceLocator.registerLazySingleton(() => http.Client());
}
