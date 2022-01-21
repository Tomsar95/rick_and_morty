import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/features/characters/data/models/character_model.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tCharacterModel = CharacterModel(
      id: 361,
      image: 'https://rickandmortyapi.com/api/character/avatar/361.jpeg',
      name: 'Toxic Rick',
      status: 'Dead',
      species: 'Humanoid',
      gender: 'Male',
      origin: 'Alien Spa',
      location: 'Earth',
      episodes: ["https://rickandmortyapi.com/api/episode/27"]);

  test('should be a number trivia entity', () {
    //assert
    expect(tCharacterModel, isA<Character>());
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('characters.json'));
      //act
      Iterable i = jsonMap['results'];
      i.map((character) => CharacterModel.fromJson(character)).toList();
      final result = i.first;
      //assert
      expect(result, tCharacterModel);
    });
  });
}
