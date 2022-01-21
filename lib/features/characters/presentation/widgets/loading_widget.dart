import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/Utils/characters_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: CharactersColors.darkBlue,),
    );
  }
}