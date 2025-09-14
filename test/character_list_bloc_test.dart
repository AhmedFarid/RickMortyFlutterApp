import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:rick_morty_app/src/presentation/list/bloc/character_list_bloc.dart';
import 'package:rick_morty_app/src/domain/usecases/get_characters_page.dart';
import 'package:rick_morty_app/src/domain/entities/paginated_characters.dart';
import 'package:rick_morty_app/src/domain/entities/character.dart';
import 'package:rick_morty_app/src/core/errors/failures.dart';

class MockGetPage extends Mock implements GetCharactersPage {}

void main() {
  late MockGetPage getPage;

  setUp(() => getPage = MockGetPage());

  final sample = PaginatedCharacters(
    items: [
      Character(id: 1,
          name: 'Rick',
          status: 'Alive',
          species: 'Human',
          imageUrl: 'url',
          origin: 'Earth',
          location: 'Citadel',
          episodesCount: 1)
    ],
    page: 1,
    hasMore: true,
  );

  blocTest<CharacterListBloc, CharacterListState>(
    'emits success with items on initial fetch',
    build: () {
      when(() => getPage(page: 1, query: any(named: 'query'))).thenAnswer((_) async => Right(sample));
      return CharacterListBloc(getPage);
    },
    act: (b) => b.add(CharactersFetched()),
    expect: () => [
      isA<CharacterListState>().having((s) => s.status, 'loading', ListStatus.loading),
      isA<CharacterListState>().having((s) => s.status, 'success', ListStatus.success).having((s)=>s.items.length, 'items', 1),
    ]
  );

  blocTest<CharacterListBloc, CharacterListState>(
  'emits failure on error',
      build: () {
        when(() => getPage(page: 1, query: any(named: 'query'))).thenAnswer((_) async => Left(ServerFailure('oops')));
        return CharacterListBloc(getPage);
      },
    act: (b) => b.add(CharactersFetched()),
    expect: () => [isA<CharacterListState>().having((s)=>s.status, 'failure', ListStatus.failure)],
  );
}