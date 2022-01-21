import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/core/error/failures.dart';
import 'package:rick_and_morty/core/use_cases/use_case.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:rick_and_morty/features/characters/domain/use_cases/get_characters.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/character/character_bloc.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters/characters_bloc.dart';

import 'characters_bloc_test.mocks.dart';

@GenerateMocks([GetCharacters])
void main() {
  late MockGetCharacters mockGetCharacters;
  late CharactersBloc bloc;

  setUp(() {
    mockGetCharacters = MockGetCharacters();
    bloc = CharactersBloc(getCharacters: mockGetCharacters);
  });

  group('GetCharacters',(){
    const tCharacter = Character(
        id: 1,
        image: 'image test',
        name: 'name test',
        status: 'status test',
        species: 'species test',
        gender: 'gender test',
        origin: 'origin test',
        location: 'location test',
        episodes: ['episode test 1', 'episode test 2']);

    const List<Character> tListCharacter = [tCharacter];

    test('initial state should be loading', () async {
      //assert
      expect(bloc.state, equals(LoadingCharactersState()));
    });

    test('Should get data from the characters use case', () async* {
      //arrange
      when(mockGetCharacters(NoParams()))
          .thenAnswer((_) async => const Right(tListCharacter));
      //act
      bloc.add(GetCharactersEvent());
      await untilCalled(mockGetCharacters(NoParams()));

      //assert
      verify(mockGetCharacters(NoParams()));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully',
            () async* {
          //arrange
          when(mockGetCharacters(any))
              .thenAnswer((_) async => const Right(tListCharacter));
          //assert later
          final expected = [
            LoadingCharacterState(),
            LoadedCharactersState(characters: tListCharacter)
          ];
          expectLater(bloc, emitsInOrder(expected));
          //act
          bloc.add(GetCharactersEvent());
        });

    test('should emit [Loading, Error] when getting data fails', () async* {
      //arrange
      when(mockGetCharacters(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expected = [
        LoadingCharacterState(),
        ErrorCharactersState(message: serverFailureMessage)
      ];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(GetCharactersEvent());
    });
  });
}