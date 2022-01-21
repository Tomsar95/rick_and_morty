import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/utils/characters_colors.dart';
import 'package:rick_and_morty/core/utils/characters_text_styles.dart';
import 'package:rick_and_morty/core/utils/helper_functions.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';

class ConcreteCharacterWidget extends StatelessWidget {
  final Character character;

  const ConcreteCharacterWidget({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding:
          const EdgeInsets.only(left: 12.0, right: 12.0, top: 26, bottom: 40),
      child: Container(
        color: CharactersColors.lightGray,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 16,),
            Text(
              'Detalle',
              textAlign: TextAlign.center,
              style: CharactersTextStyles.robotoBold().copyWith(fontSize: 24.0),
              overflow: TextOverflow.ellipsis,
            ),
            buildImage(),
            Text(character.name,
                style: CharactersTextStyles.robotoBold().copyWith(fontSize: 24.0),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center),
            const SizedBox(height: 26,),
            buildGeneralData(),
          ],
        ),
      ),
    ));
  }

  Widget buildImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: CachedNetworkImage(
            imageUrl: character.image,
            fit: BoxFit.fitWidth,
            placeholder: (context, url) => Container(
                color: CharactersColors.lightGray,
                child: const Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: CharactersColors.darkBlue,
                ))),
          ),
        ),
      ),
    );
  }

  Widget buildGeneralData() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('- Gender: '+character.gender,
                style: CharactersTextStyles.robotoRegular(),
                overflow: TextOverflow.ellipsis),
            Text('- Origin: '+character.origin,
                style: CharactersTextStyles.robotoRegular(),
                overflow: TextOverflow.ellipsis),
            Text('- Location: '+character.location,
                style: CharactersTextStyles.robotoRegular(),
                overflow: TextOverflow.ellipsis),
            Text('- Number of episodes: '+HelperFunctions.getNumberOfEpisodesForCharacter(character.episodes),
                style: CharactersTextStyles.robotoRegular(),
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
