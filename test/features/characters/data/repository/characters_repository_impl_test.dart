import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:rick_and_morty/features/characters/data/datasources/characters_remote_data_source.dart';
import 'package:rick_and_morty/features/characters/data/repositories/characters_repository_impl.dart';

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
    repository = CharactersRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });


}
