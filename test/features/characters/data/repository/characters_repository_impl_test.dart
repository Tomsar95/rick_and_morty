import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/core/error/failures.dart';
import 'package:rick_and_morty/features/characters/data/datasources/characters_remote_data_source.dart';
import 'package:rick_and_morty/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';

import 'characters_repository_impl_test.mocks.dart';

@GenerateMocks([
  CharactersRemoteDataSource
], customMocks: [
  MockSpec<CharactersRemoteDataSource>(
      as: #MockNumberTriviaRemoteDataSourceForTest,
      returnNullOnMissingStub: true),
])
void main() {
  late CharactersRepositoryImpl repository;
  late MockCharactersRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockCharactersRemoteDataSource();
    repository =
        CharactersRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('getCharacters', () {
    const tCharacter = Character(
        id: 1,
        image: 'image test',
        name: 'name test',
        status: 'status test',
        species: 'species test',
        origin: 'origin test',
        location: 'location test',
        episodes: ['episode test 1', 'episode test 2']);

    const tCharacters = [tCharacter];

    test('should return remote data when the call to remote data source is successful', () async {
      //arrange
      when(mockRemoteDataSource.getCharacters())
          .thenAnswer((_) async => tCharacters);
      //act
      final result = await repository.getCharacters();
      //assert
      verify(mockRemoteDataSource.getCharacters());
      expect(result, equals(const Right(tCharacters)));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          //arrange
          when(mockRemoteDataSource.getCharacters())
              .thenThrow(ServerException('ServerException'));
          //act
          final result = await repository.getCharacters();
          //assert
          verify(mockRemoteDataSource.getCharacters());
          expect(result, equals(Left(ServerFailure())));
        });
  });

  group('getConcreteCharacter', () {
    const tCharacter = Character(
        id: 1,
        image: 'image test',
        name: 'name test',
        status: 'status test',
        species: 'species test',
        origin: 'origin test',
        location: 'location test',
        episodes: ['episode test 1', 'episode test 2']);

    const tId = 1;

    test(
        'should return remote data when the call to remote data source is successful',
            () async {
          //arrange
          when(mockRemoteDataSource.getConcreteCharacter(any))
              .thenAnswer((_) async => tCharacter);
          //act
          final result = await repository.getConcreteCharacter(tId);
          //assert
          verify(mockRemoteDataSource.getConcreteCharacter(tId));
          expect(result, equals(const Right(tCharacter)));
        });

    test(
        'should return serverfailure when the call to remote data source is unsuccessful',
            () async {
          //arrange
          when(mockRemoteDataSource.getConcreteCharacter(any))
              .thenThrow(ServerException('ServerException'));
          //act
          final result = await repository.getConcreteCharacter(tId);
          //assert
          verify(mockRemoteDataSource.getConcreteCharacter(tId));
          expect(result, equals(Left(ServerFailure())));
        });
  });
}
