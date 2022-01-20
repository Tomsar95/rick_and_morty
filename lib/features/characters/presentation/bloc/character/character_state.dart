part of 'character_bloc.dart';

@immutable
abstract class CharacterState extends Equatable {}

class EmptyState extends CharacterState {
  @override
  List<Object> get props => [];
}

class LoadingCharacterState extends CharacterState {
  @override
  List<Object> get props => [];
}

class LoadedCharacterState extends CharacterState {
  final Character character;

  LoadedCharacterState({required this.character}) : super();

  @override
  List<Object> get props => [];
}

class ErrorCharacterState extends CharacterState {
  final String message;

  ErrorCharacterState({required this.message}) : super();

  @override
  List<Object> get props => [];
}
