import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_morty_app/src/data/repositories/character_repository_impl.dart';
import 'package:rick_morty_app/src/data/datasources/character_remote_ds.dart';
import 'package:rick_morty_app/src/data/models/paginated_characters_dto.dart';

class MockRemote extends Mock implements CharacterRemoteDataSource {}

void main() {
  late MockRemote remote;
  late CharacterRepositoryImpl repo;

  setUp(() {
  remote = MockRemote();
  repo = CharacterRepositoryImpl(remote);
  });

  test('getCharacters returns Right on success', () async {
    final dto = PaginatedCharactersDto.fromJson({
      'info': {'next': 'https://rickandmortyapi.com/api/character?page=2'},
      'results': [
        {
          'id': 1, 'name': 'Rick', 'status': 'Alive', 'species': 'Human', 'image': 'url',
          'origin': {'name': 'Earth'}, 'location': {'name': 'Citadel'}, 'episode': ['e1']
        }
      ],
    });
    when(() => remote.getCharacters(page: 1, name: any(named: 'name'))).thenAnswer((_) async => dto);

    final res = await repo.getCharacters(page: 1, name: null);
    expect(res.isRight(), true);
  });
}