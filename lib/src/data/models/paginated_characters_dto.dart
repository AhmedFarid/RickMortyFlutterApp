import 'character_dto.dart';

class PaginatedCharactersDto {
  final List<CharacterDto> results;
  final int? nextPage;

  PaginatedCharactersDto.fromJson(Map<String, dynamic> json)
      : results = (json['results'] as List)
      .map((e) => CharacterDto.fromJson(e as Map<String, dynamic>))
      .toList(),
        nextPage = _extractPageFromUrl(json['info']?['next']);

  static int? _extractPageFromUrl(dynamic nextUrl) {
    if (nextUrl == null) return null;
    final uri = Uri.parse(nextUrl as String);
    final p = uri.queryParameters['page'];
    return p == null ? null : int.tryParse(p);
  }
}