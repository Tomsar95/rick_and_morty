import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/core/error/failures.dart';
import 'package:rick_and_morty/core/use_cases/use_case.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/characters_repository.dart';

class GetConcreteCharacter implements UseCase<Character, Params> {
  final CharactersRepository repository;

  GetConcreteCharacter(this.repository);

  @override
  Future<Either<Failure, Character>> call(Params params) async {
    return await repository.getConcreteCharacter(params.id);
  }
}

class Params extends Equatable {
  final int id;

  const Params({required this.id}) : super();

  @override
  List<Object?> get props => throw UnimplementedError();
}