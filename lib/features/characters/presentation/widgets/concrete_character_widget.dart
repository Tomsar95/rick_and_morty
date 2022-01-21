import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/utils/characters_colors.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';

class ConcreteCharacterWidget extends StatelessWidget {
  final Character character;

  const ConcreteCharacterWidget({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      color: CharactersColors.lightGray,
      child: Center(
        child: Text(character.name),
      ),
    ));
  }
}
