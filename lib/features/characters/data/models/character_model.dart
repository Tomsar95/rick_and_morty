import 'package:rick_and_morty/features/characters/domain/entities/character.dart';

class CharacterModel extends Character {
  const CharacterModel(
      {required int id,
      required String image,
      required String name,
      required String status,
      required String species,
      required String origin,
      required String location,
      required List<dynamic> episodes})
      : super(
            id: id,
            image: image,
            name: name,
            status: status,
            species: species,
            origin: origin,
            location: location,
            episodes: episodes);

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      origin: json['origin']['name'],
      location: json['location']['name'],
      episodes: json['episode'],
    );
  }
}
