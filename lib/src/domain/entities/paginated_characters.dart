import 'package:rick_morty_app/src/domain/entities/character.dart';

class PaginatedCharacters {
  final List<Character> items;
  final int page;
  final bool hasMore;
  PaginatedCharacters({required this.items, required this.page, required this.hasMore});
}