import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:rick_morty_app/src/core/network/dio_client.dart';
import 'package:rick_morty_app/src/data/datasources/character_remote_ds.dart';
import 'package:rick_morty_app/src/data/repositories/character_repository_impl.dart';
import 'package:rick_morty_app/src/domain/repositories/character_repository.dart';
import 'package:rick_morty_app/src/domain/usecases/get_character_by_id.dart';
import 'package:rick_morty_app/src/domain/usecases/get_characters_page.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  // Network
  sl.registerLazySingleton<Dio>(() => buildDio());

  // Data Source
  sl.registerLazySingleton<CharacterRemoteDataSource>(() => CharacterRemoteDataSourceImpl(sl()));

  // Repositroy
  sl.registerLazySingleton<CharacterRepository>(() => CharacterRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetCharactersPage(sl()));
  sl.registerLazySingleton(() => GetCharacterById(sl()));
}