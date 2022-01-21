import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/error/failures.dart';
import 'package:rick_and_morty/core/use_cases/use_case.dart';
import 'package:rick_and_morty/features/characters/domain/entities/series.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/characters_repository.dart';

class GetSeries implements UseCase<Series, NoParams> {
  final CharactersRepository repository;

  GetSeries(this.repository);

  @override
  Future<Either<Failure, Series>> call(NoParams params) async {
    return await repository.getSeries();
  }
}