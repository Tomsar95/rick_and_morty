import 'package:rick_and_morty/features/characters/domain/entities/character.dart';

abstract class CharactersRemoteDataSource{
  /// Calls the https://rickandmortyapi.com/api/location/{id} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Character>? getConcreteCharacter(int id);

  /// Calls the https://rickandmortyapi.com/api/character endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<Character>> getCharacters();
}