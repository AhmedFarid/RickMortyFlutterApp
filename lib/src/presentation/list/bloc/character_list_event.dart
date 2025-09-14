part of 'character_list_bloc.dart';

abstract class CharacterListEvent extends Equatable {
  const CharacterListEvent();
  @override
  List<Object?> get props => [];
}

class CharactersFetched extends CharacterListEvent {}
class CharactersRefreshed extends CharacterListEvent {}
class CharactersSearched extends CharacterListEvent {
  final String? query;
  const CharactersSearched(this.query);
  @override
  List<Object?> get props => [query];
}