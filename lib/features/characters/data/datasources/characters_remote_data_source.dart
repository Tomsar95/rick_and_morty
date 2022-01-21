import 'dart:convert';

import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/features/characters/data/models/character_model.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:http/http.dart' as http;

abstract class CharactersRemoteDataSource{
  /// Calls the https://rickandmortyapi.com/api/character/{id} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Character> getConcreteCharacter(int id);

  /// Calls the https://rickandmortyapi.com/api/character endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<Character>> getCharacters();
}

class CharactersRemoteDataSourceImpl implements CharactersRemoteDataSource{
  final http.Client client;

  CharactersRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Character>> getCharacters() async {
    return _getCharactersFromUrl('https://rickandmortyapi.com/api/character');
  }

  @override
  Future<Character> getConcreteCharacter(int id) async {
    return _getConcreteCharacterFromUrl('https://rickandmortyapi.com/api/character/$id');
  }

  Future<List<CharacterModel>> _getCharactersFromUrl(String url) async{
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    if(response.statusCode == 200){
      final Map<String, dynamic> jsonMap =
      json.decode(response.body);
      Iterable i = jsonMap['results'];
      i.map((character) => CharacterModel.fromJson(character)).toList();
      return i.map((character) => CharacterModel.fromJson(character)).toList();
    } else {
      throw ServerException('Bad Status Code');
    }
  }

  Future<CharacterModel> _getConcreteCharacterFromUrl(String url) async{
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      return CharacterModel.fromJson(json);
    } else {
      throw ServerException('Bad Status Code');
    }
  }
}