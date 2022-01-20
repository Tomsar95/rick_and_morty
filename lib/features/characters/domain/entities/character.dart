import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final int id;
  final String image;
  final String name;
  final String status;
  final String species;
  final String origin;
  final String location;
  final List<dynamic> episodes;

  const Character(
      {required this.id,
      required this.image,
      required this.name,
      required this.status,
      required this.species,
      required this.origin,
      required this.location,
      required this.episodes});

  @override
  List<Object> get props => [];
}
