import 'package:rick_morty_app/src/core/errors/failures.dart';
import 'package:rick_morty_app/src/domain/entities/character.dart';
import 'package:rick_morty_app/src/domain/entities/paginated_characters.dart';
import 'package:dartz/dartz.dart';

abstract class CharacterRepository {
  Future<Either<Failure, PaginatedCharacters>> getCharacters({required int page, String? name});
  Future<Either<Failure, Character>> getCharacterById(int id);
}