import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/core/error/failures.dart';
import 'package:rick_and_morty/core/use_cases/use_case.dart';
import 'package:rick_and_morty/core/utils/helper_functions.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:rick_and_morty/features/characters/domain/use_cases/get_characters.dart';
import 'package:rick_and_morty/features/characters/domain/use_cases/get_series.dart';

part 'characters_event.dart';

part 'characters_state.dart';

const String serverFailureMessage = 'Server Failure.';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final GetCharacters getCharacters;
  final GetSeries getSeries;

  CharactersBloc(
      {required this.getCharacters, required this.getSeries})
      : super(LoadingCharactersState()) {
    on<GetCharactersEvent>((event, emit) async {
      emit(LoadingCharactersState());
      final seriesOrFailure = await getSeries(NoParams());
      await seriesOrFailure.fold((failure) {
        emit(ErrorCharactersState(message: _mapFailureToMessage(failure)));
      }, (numberOfEpisodes) async {
        final failureOrCharacters = await getCharacters(NoParams());
        failureOrCharacters.fold((failure) {
          emit(ErrorCharactersState(message: _mapFailureToMessage(failure)));
        }, (characters) {
          emit(LoadedCharactersState(characters: characters, numberOfEpisodes: HelperFunctions.getNumberOfEpisodes(numberOfEpisodes)));
        });
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
