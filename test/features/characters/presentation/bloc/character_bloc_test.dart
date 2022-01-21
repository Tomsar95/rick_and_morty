import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/core/error/failures.dart';
import 'package:rick_and_morty/core/use_cases/use_case.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:rick_and_morty/features/characters/domain/use_cases/get_concrete_character.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/character/character_bloc.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters/characters_bloc.dart';

import 'character_bloc_test.mocks.dart';


@GenerateMocks([GetConcreteCharacter])
void main() {
  late MockGetConcreteCharacter mockGetConcreteCharacter;
  late CharacterBloc bloc;

  setUp(() {
    mockGetConcreteCharacter = MockGetConcreteCharacter();
    bloc = CharacterBloc(getConcreteCharacter: mockGetConcreteCharacter);
  });

  group('GetCharacters',(){
    const tId = 1;
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

    test('initial state should be loading', () async {
      //assert
      expect(bloc.state, equals(LoadingCharacterState()));
    });

    test('Should get data from the character use case', () async* {
      //arrange
      when(mockGetConcreteCharacter(const Params(id: tId)))
          .thenAnswer((_) async => const Right(tCharacter));
      //act
      bloc.add(const GetConcreteCharacterEvent(tId));
      await untilCalled(mockGetConcreteCharacter(const Params(id: tId)));

      //assert
      verify(mockGetConcreteCharacter(const Params(id: tId)));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully',
            () async* {
          //arrange
          when(mockGetConcreteCharacter(any))
              .thenAnswer((_) async => const Right(tCharacter));
          //assert later
          final expected = [
            LoadingCharacterState(),
            LoadedCharacterState(character: tCharacter)
          ];
          expectLater(bloc, emitsInOrder(expected));
          //act
          bloc.add(const GetConcreteCharacterEvent(tId));
        });

    test('should emit [Loading, Error] when getting data fails', () async* {
      //arrange
      when(mockGetConcreteCharacter(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expected = [
        LoadingCharacterState(),
        ErrorCharacterState(message: serverFailureMessage)
      ];
      expectLater(bloc, emitsInOrder(expected));
      //act
      bloc.add(const GetConcreteCharacterEvent(tId));
    });
  });
}