import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/utils/characters_colors.dart';

class CoreWidgets {
  static AppBar charactersAppBar(context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: Image.asset(
              'assets/images/alfred.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      backgroundColor: CharactersColors.darkBlue,
    );
  }
}
