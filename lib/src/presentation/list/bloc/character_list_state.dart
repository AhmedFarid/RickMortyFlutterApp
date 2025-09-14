part of 'character_list_bloc.dart';

enum ListStatus { initial, loading, success, failure }

class CharacterListState extends Equatable {
  final ListStatus status;
  final List<Character> items;
  final int page;
  final bool hasReachedMax;
  final String? query;
  final String? error;

  const CharacterListState({
    required this.status,
    required this.items,
    required this.page,
    required this.hasReachedMax,
    required this.query,
    required this.error,
  });

  const CharacterListState.initial()
      : status = ListStatus.initial,
        items = const [],
        page = 0,
        hasReachedMax = false,
        query = null,
        error = null;

  bool get isLoading => status == ListStatus.loading;

  CharacterListState copyWith({
    ListStatus? status,
    List<Character>? items,
    int? page,
    bool? hasReachedMax,
    String? query,
    String? error,
  }) {
    return CharacterListState(
      status: status ?? this.status,
      items: items ?? this.items,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      query: query ?? this.query,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, items, page, hasReachedMax, query, error];
}