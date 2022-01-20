import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/core/error/failures.dart';
import 'package:rick_and_morty/core/use_cases/use_case.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:rick_and_morty/features/characters/domain/use_cases/get_characters.dart';
import 'package:rick_and_morty/features/characters/domain/use_cases/get_concrete_character.dart';

part 'characters_event.dart';

part 'characters_state.dart';

const String serverFailureMessage = 'Server Failure.';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final GetCharacters getCharacters;

  CharactersBloc(
      {required this.getCharacters})
      : super(LoadingCharactersState()) {
    on<GetCharactersEvent>((event, emit) async {
      emit(LoadingCharactersState());
      final failureOrCharacters = await getCharacters(NoParams());
      failureOrCharacters.fold((failure) {
        emit(ErrorCharactersState(message: _mapFailureToMessage(failure)));
      }, (characters) {
        emit(LoadedCharactersState(characters: characters));
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
