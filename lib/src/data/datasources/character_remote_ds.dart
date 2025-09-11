import 'package:dio/dio.dart';
import 'package:rick_morty_app/src/core/errors/exceptions.dart';
import 'package:rick_morty_app/src/data/models/character_dto.dart';
import 'package:rick_morty_app/src/data/models/paginated_characters_dto.dart';

abstract class CharacterRemoteDataSource {
  Future<PaginatedCharactersDto> getCharacters({required int page, String? name});
  Future<CharacterDto> getCharacterById(int id);
}

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final Dio dio;
  CharacterRemoteDataSourceImpl(this.dio);

  @override
  Future<PaginatedCharactersDto> getCharacters({required int page, String? name}) async {
    try {
      final resp = await dio.get('character', queryParameters: {
        'page': page,
        if (name != null && name.isNotEmpty) 'name': name,
      });
      return PaginatedCharactersDto.fromJson(resp.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.unknown || e.type == DioExceptionType.connectionError) {
        throw NotNullableError('No internet connection');
      }
      final status = e.response?.statusCode;
      final message = e.response?.data is Map && e.response?.data['error'] != null
          ? e.response?.data['error'].toString()
          : 'Server error';
      throw ServerException(statusCode: status, message: message);
    }
  }

  @override
  Future<CharacterDto> getCharacterById(int id) async {
    try {
      final resp = await dio.get('character/$id');
      return CharacterDto.fromJson(resp.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.unknown || e.type == DioExceptionType.connectionError) {
        throw NotNullableError('No internet connection');
      }
      throw ServerException(statusCode: e.response?.statusCode, message: 'Failed to load character');
    }
  }
}