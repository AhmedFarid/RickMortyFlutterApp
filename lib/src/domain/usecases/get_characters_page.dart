import 'package:dartz/dartz.dart';
import 'package:rick_morty_app/src/core/errors/failures.dart';
import 'package:rick_morty_app/src/domain/entities/paginated_characters.dart';
import 'package:rick_morty_app/src/domain/repositories/character_repository.dart';

class GetCharactersPage {
  final CharacterRepository repo;
  GetCharactersPage(this.repo);

  Future<Either<Failure, PaginatedCharacters>> call({required int page, String? query}) {
    return repo.getCharacters(page: page, name: query);
  }
 }