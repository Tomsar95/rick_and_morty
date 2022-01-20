part of 'character_bloc.dart';

@immutable
abstract class CharacterEvent extends Equatable{
  const CharacterEvent();
}

class GetConcreteCharacterEvent extends CharacterEvent{
  final int id;

  const GetConcreteCharacterEvent(this.id) : super();
  @override
  List<Object?> get props => [];
}
