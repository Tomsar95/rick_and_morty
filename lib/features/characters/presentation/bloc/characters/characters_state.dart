part of 'characters_bloc.dart';

@immutable
abstract class CharactersState extends Equatable {}

class EmptyState extends CharactersState {
  @override
  List<Object> get props => [];
}

class LoadingCharactersState extends CharactersState {
  @override
  List<Object> get props => [];
}

class LoadedCharactersState extends CharactersState {
  final List<Character> characters;
  final String numberOfEpisodes;

  LoadedCharactersState(
      {required this.characters, required this.numberOfEpisodes})
      : super();

  @override
  List<Object> get props => [];
}

class ErrorCharactersState extends CharactersState {
  final String message;

  ErrorCharactersState({required this.message}) : super();

  @override
  List<Object> get props => [];
}
