import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/error/failures.dart';
import 'package:rick_and_morty/features/characters/domain/entities/series.dart';

class HelperFunctions {
  static bool characterIsAlive(String status){
    if(status.toLowerCase() == 'alive'){
      return true;
    }
    return false;
  }

  static String getNumberOfEpisodesForCharacter(List episodes){
    if(episodes.isEmpty) return '0';
    return episodes.length.toString();
  }

  static String getNumberOfEpisodes(Series series){
    return series.numberOfEpisodes.toString();
  }
}