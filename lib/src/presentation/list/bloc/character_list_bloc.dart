import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_morty_app/src/domain/entities/character.dart';
import 'package:rick_morty_app/src/domain/entities/paginated_characters.dart';
import 'package:rick_morty_app/src/domain/usecases/get_characters_page.dart';
import 'package:stream_transform/stream_transform.dart';

part 'character_list_event.dart';
part 'character_list_state.dart';

// Debounce transform for search
EventTransformer<E> debounce<E>(Duration d) {
  return (events, mapper) => events.debounce(d).switchMap(mapper);
}

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  final GetCharactersPage getPage;

  CharacterListBloc(this.getPage) : super(const CharacterListState.initial()) {
    on<CharactersFetched>(_onFetched);
    on<CharactersRefreshed>(_onRefreshed);
    on<CharactersSearched>(_onSearched, transformer: debounce(const Duration(milliseconds: 350)));
  }

  Future<void> _load({required int page, String? query, required Emitter<CharacterListState> emit, bool append = false}) async {
    if (state.isLoading) return;
    emit(state.copyWith(status: ListStatus.loading));
    final result = await getPage(page: page, query: query);
    result.fold(
        (f) => emit(state.copyWith(status: ListStatus.failure, error: f.message)),
        (PaginatedCharacters data) {
          final newItmes = append ? [...state.items, ...data.items] : data.items;
          emit(state.copyWith(
            status:  ListStatus.success,
            items: newItmes,
            page: data.page,
            hasReachedMax: !data.hasMore,
            query: query ?? state.query,
          ));
        },
    );
  }

  Future<void> _onFetched(CharactersFetched e, Emitter<CharacterListState> emit) async {
    final nextPage = state.items.isEmpty ? 1 : state.page +1;
    if (state.hasReachedMax && state.items.isNotEmpty) return;
    await _load(page: nextPage, query: state.query, emit: emit, append: state.items.isNotEmpty);
  }

  Future<void> _onRefreshed(CharactersRefreshed e, Emitter<CharacterListState> emit) async {
    await _load(page: 1, query: state.query, emit: emit, append: false);
  }

  Future<void> _onSearched(CharactersSearched e, Emitter<CharacterListState> emit) async {
    await _load(page: 1, query: e.query, emit: emit, append: false);
  }
}
