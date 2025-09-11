import 'package:dartz/dartz.dart';
import 'package:rick_morty_app/src/core/errors/exceptions.dart';
import 'package:rick_morty_app/src/core/errors/failures.dart';
import 'package:rick_morty_app/src/data/datasources/character_remote_ds.dart';
import 'package:rick_morty_app/src/domain/entities/character.dart';
import 'package:rick_morty_app/src/domain/entities/paginated_characters.dart';
import 'package:rick_morty_app/src/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository  {
  final CharacterRemoteDataSource remote;
  CharacterRepositoryImpl(this.remote);

  Character _mapDto(dto) => Character(
    id: dto.id,
    name: dto.name,
    status: dto.status,
    species: dto.species,
    imageUrl: dto.image,
    origin: dto.originName,
    location: dto.locationName,
    episodesCount: dto.episode.length,
  );

  @override
  Future<Either<Failure, PaginatedCharacters>> getCharacters({required int page, String? name}) async {
    try {
      final dto = await remote.getCharacters(page: page, name: name);
      final items = dto.results.map(_mapDto).toList();
      final hasMore = dto.nextPage != null;
      return Right(PaginatedCharacters(items: items, page: page, hasMore: hasMore));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure('${e.statusCode ?? ''} ${e.message}'.trim()));
    } catch (e) {
      return Left(UnknownFailure('Unexpected error'));
    }
  }

  @override
  Future<Either<Failure, Character>> getCharacterById(int id) async {
    try {
      final dto = await remote.getCharacterById(id);
      return Right(_mapDto(dto));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure('${e.statusCode ?? ''} ${e.message}'.trim()));
    } catch (_) {
      return Left(UnknownFailure('Unexpected error'));
    }
  }
}