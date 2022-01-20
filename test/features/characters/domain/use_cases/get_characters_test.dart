import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/core/use_cases/use_case.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/characters_repository.dart';
import 'package:rick_and_morty/features/characters/domain/use_cases/get_characters.dart';

import 'get_characters_test.mocks.dart';

@GenerateMocks([CharactersRepository])
void main() {
  late final GetCharacters useCase;
  late final MockCharactersRepository mockCharactersRepository;

  setUp(() {
    mockCharactersRepository = MockCharactersRepository();
    useCase = GetCharacters(mockCharactersRepository);
  });

  const tCharacter = Character(
      id: 1,
      image: 'image test',
      name: 'name test',
      status: 'status test',
      species: 'species test',
      origin: 'origin test',
      location: 'location test',
      episodes: ['episode test 1', 'episode test 2']);

  const List<Character> tListCharacter = [tCharacter];

  test('should get List<Character> from the repository', () async {
    // arrange
    when(mockCharactersRepository.getCharacters())
        .thenAnswer((_) async => const Right(tListCharacter));
    // act
    final result = await useCase(NoParams());
    // assert
    expect(result, const Right(tListCharacter));
    verify(mockCharactersRepository.getCharacters());
    verifyNoMoreInteractions(mockCharactersRepository);
  });
}
