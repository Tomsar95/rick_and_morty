import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/core/use_cases/use_case.dart';
import 'package:rick_and_morty/features/characters/domain/entities/series.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/characters_repository.dart';
import 'package:rick_and_morty/features/characters/domain/use_cases/get_series.dart';

import 'get_characters_test.mocks.dart';

@GenerateMocks([CharactersRepository])
void main() {
  late final GetSeries useCase;
  late final MockCharactersRepository mockCharactersRepository;

  setUp(() {
    mockCharactersRepository = MockCharactersRepository();
    useCase = GetSeries(mockCharactersRepository);
  });

  const tSeries = Series(
      numberOfEpisodes: 1);

  test('should get series from the repository', () async {
    // arrange
    when(mockCharactersRepository.getSeries())
        .thenAnswer((_) async => const Right(tSeries));
    // act
    final result = await useCase(NoParams());
    // assert
    expect(result, const Right(tSeries));
    verify(mockCharactersRepository.getSeries());
    verifyNoMoreInteractions(mockCharactersRepository);
  });
}