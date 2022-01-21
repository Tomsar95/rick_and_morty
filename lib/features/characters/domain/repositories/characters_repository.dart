import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/error/failures.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:rick_and_morty/features/characters/domain/entities/series.dart';

abstract class CharactersRepository {
  Future<Either<Failure, List<Character>>> getCharacters();
  Future<Either<Failure, Character>> getConcreteCharacter(int id);
  Future<Either<Failure, Series>> getSeries();
}