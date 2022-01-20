part of 'characters_bloc.dart';

@immutable
abstract class CharactersEvent extends Equatable{
  const CharactersEvent();
}

class GetCharactersEvent extends CharactersEvent{
  @override
  List<Object?> get props => [];
}
