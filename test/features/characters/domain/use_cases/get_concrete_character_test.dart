import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/core/use_cases/use_case.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/characters_repository.dart';
import 'package:rick_and_morty/features/characters/domain/use_cases/get_characters.dart';
import 'package:rick_and_morty/features/characters/domain/use_cases/get_concrete_character.dart';

import 'get_concrete_character_test.mocks.dart';

@GenerateMocks([CharactersRepository])
void main() {
  late final GetConcreteCharacter useCase;
  late final MockCharactersRepository mockCharactersRepository;

  setUp(() {
    mockCharactersRepository = MockCharactersRepository();
    useCase = GetConcreteCharacter(mockCharactersRepository);
  });

  const tId = 1;
  const tCharacter = Character(
      id: 1,
      image: 'image test',
      name: 'name test',
      status: 'status test',
      species: 'species test',
      origin: 'origin test',
      location: 'location test',
      episodes: ['episode test 1', 'episode test 2']);


  test('should get Concrete Character from the repository', () async {
    // arrange
    when(mockCharactersRepository.getConcreteCharacter(any))
        .thenAnswer((_) async => const Right(tCharacter));
    // act
    final result = await useCase(const Params(id: tId));
    // assert
    expect(result, const Right(tCharacter));
    verify(mockCharactersRepository.getConcreteCharacter(tId));
    verifyNoMoreInteractions(mockCharactersRepository);
  });
}