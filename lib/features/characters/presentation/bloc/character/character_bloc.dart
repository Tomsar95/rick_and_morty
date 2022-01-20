import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/core/error/failures.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:rick_and_morty/features/characters/domain/use_cases/get_concrete_character.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters/characters_bloc.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetConcreteCharacter getConcreteCharacter;

  CharacterBloc({required this.getConcreteCharacter}) : super(LoadingCharacterState()) {
    on<GetConcreteCharacterEvent>((event, emit) async {
      emit(LoadingCharacterState());
      final failureOrCharacters = await getConcreteCharacter(Params(id: event.id));
      failureOrCharacters.fold((failure) {
        emit(ErrorCharacterState(message: _mapFailureToMessage(failure)));
      }, (character) {
        emit(LoadedCharacterState(character: character));
      });
    });
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return serverFailureMessage;
    default:
      return 'Unexpected error';
  }
}
