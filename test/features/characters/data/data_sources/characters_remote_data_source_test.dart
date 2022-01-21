import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/features/characters/data/datasources/characters_remote_data_source.dart';
import 'package:rick_and_morty/features/characters/data/models/character_model.dart';
import 'package:rick_and_morty/features/characters/data/models/series_model.dart';

import '../../../../fixtures/fixture_reader.dart';

import 'characters_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late CharactersRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = CharactersRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockkHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
            (_) => Future.value(http.Response(fixture('characters.json'), 200)));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
            (_) => Future.value(http.Response('something went wrong', 404)));
  }

  void setUpMockkHttpClientSuccess200Series() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
            (_) => Future.value(http.Response(fixture('series.json'), 200)));
  }

  group('getConcreteCharacter', () {
    const tId = 1;
    final Map<String, dynamic> jsonMap =
    json.decode(fixture('characters.json'));
    Iterable i = jsonMap['results'];
    final tCharacters =  i.map((character) => CharacterModel.fromJson(character)).toList();
    final tCharacter = tCharacters.first;
    test(
        'should perform a GET request on a URL with number being the endpoint and with application/json header',
            () async {
          //arrange
          setUpMockkHttpClientSuccess200();
          //act
          dataSource.getConcreteCharacter(tId);
          //assert
          verify(mockHttpClient.get(
            Uri.parse('https://rickandmortyapi.com/api/character/$tId'),
            headers: {'Content-Type': 'application/json'},
          ));
        });

    test('should return Character when response code is 200',() async {
      //arrange
      setUpMockkHttpClientSuccess200();
      //act
      final result = await dataSource.getConcreteCharacter(tId);
      //assert
      expect(result, equals(tCharacter));
    });

    test('should throw ServerException when response code is 404 or other',() async {
      //arrange
      setUpMockHttpClientFailure404();
      //act
      final call = dataSource.getConcreteCharacter;
      //assert
      expect(() => call(tId), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('getCharacters', () {
    final Map<String, dynamic> jsonMap =
    json.decode(fixture('characters.json'));
    Iterable i = jsonMap['results'];
    final tCharacters =  i.map((character) => CharacterModel.fromJson(character)).toList();
    test(
        'should perform a GET request on a URL with application/json header',
            () async {
          //arrange
          setUpMockkHttpClientSuccess200();
          //act
          dataSource.getCharacters();
          //assert
          verify(mockHttpClient.get(
            Uri.parse('https://rickandmortyapi.com/api/character'),
            headers: {'Content-Type': 'application/json'},
          ));
        });

    test('should return List<Character> when response code is 200',() async {
      //arrange
      setUpMockkHttpClientSuccess200();
      //act
      final result = await dataSource.getCharacters();
      //assert
      expect(result, equals(tCharacters));
    });

    test('should throw ServerException when response code is 404 or other',() async {
      //arrange
      setUpMockHttpClientFailure404();
      //act
      final call = dataSource.getCharacters;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('getSeries',() {
    final Map<String, dynamic> jsonMap =
    json.decode(fixture('series.json'));
    final tSeries = SeriesModel.fromJson(jsonMap['info']);

    test(
        'should perform a GET request on a URL with application/json header',
            () async {
          //arrange
          setUpMockkHttpClientSuccess200Series();
          //act
          dataSource.getSeries();
          //assert
          verify(mockHttpClient.get(
            Uri.parse('https://rickandmortyapi.com/api/episode'),
            headers: {'Content-Type': 'application/json'},
          ));
        });

    test('should return Series when response code is 200',() async {
      //arrange
      setUpMockkHttpClientSuccess200Series();
      //act
      final result = await dataSource.getSeries();
      //assert
      expect(result, equals(tSeries));
    });

    test('should throw ServerException when response code is 404 or other',() async {
      //arrange
      setUpMockHttpClientFailure404();
      //act
      final call = dataSource.getSeries;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}