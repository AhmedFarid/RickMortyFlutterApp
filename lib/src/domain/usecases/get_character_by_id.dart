import 'package:dartz/dartz.dart';
import 'package:rick_morty_app/src/core/errors/failures.dart';
import 'package:rick_morty_app/src/domain/entities/character.dart';
import 'package:rick_morty_app/src/domain/entities/paginated_characters.dart';
import 'package:rick_morty_app/src/domain/repositories/character_repository.dart';

class GetCharacterById {
  final CharacterRepository repo;
  GetCharacterById(this.repo);
  Future<Either<Failure, Character>> call(int id) => repo.getCharacterById(id);
}