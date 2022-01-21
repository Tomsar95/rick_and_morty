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
}