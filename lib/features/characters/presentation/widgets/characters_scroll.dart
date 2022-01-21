import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/utils/characters_text_styles.dart';
import 'package:rick_and_morty/core/utils/characters_colors.dart';
import 'package:rick_and_morty/core/utils/helper_functions.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:rick_and_morty/features/characters/presentation/pages/concrete_character_page.dart';

class CharactersScroll extends StatefulWidget {
  final List<Character> characters;
  final String numberOfEpisodes;

  const CharactersScroll({Key? key, required this.characters, required this.numberOfEpisodes})
      : super(key: key);

  @override
  _CharactersScrollState createState() => _CharactersScrollState();
}

class _CharactersScrollState extends State<CharactersScroll> {
  @override
  Widget build(BuildContext context) {
    List<Widget> sliverList = [];
    sliverList.add(SliverToBoxAdapter(
      child: bannerTile(),
    ));
    sliverList.add(SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, index) {
          return CharacterTile(
            character: widget.characters[index],
          );
        },
        childCount: widget.characters.length,
      )),
    ));
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      slivers: sliverList,
    );
  }

  Widget bannerTile() {
    return Container(height: 100, color: CharactersColors.lightGray, child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'La serie en números',
          style: CharactersTextStyles.robotoBold().copyWith(fontSize: 24),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          widget.numberOfEpisodes+' Número de episodios',
          style: CharactersTextStyles.robotoBold(),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),);
  }
}

class CharacterTile extends StatefulWidget {
  final Character character;

  const CharacterTile({Key? key, required this.character}) : super(key: key);

  @override
  _CharacterTileState createState() => _CharacterTileState();
}

class _CharacterTileState extends State<CharacterTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.16,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildImage(),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Container(
                color: CharactersColors.lightGray,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => characterTapped(widget.character.id),
                        child: Text(
                          widget.character.name,
                          style: CharactersTextStyles.robotoBold(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      buildStatus(),
                      Text(
                        widget.character.species,
                        style: CharactersTextStyles.robotoRegular(),
                        overflow: TextOverflow.ellipsis,
                      ),
                      buildDetailButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return GestureDetector(
      onTap: () => characterTapped(widget.character.id),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: CachedNetworkImage(
            imageUrl: widget.character.image,
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

  Widget buildStatus() {
    return Row(
      children: [
        ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            child: Container(
              height: 14,
              width: 14,
              color: HelperFunctions.characterIsAlive(widget.character.status)
                  ? CharactersColors.greenAccent
                  : CharactersColors.darkGray,
            )),
        const SizedBox(
          width: 8,
        ),
        Text(
          widget.character.status,
          style: CharactersTextStyles.robotoRegular(),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget buildDetailButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
        style: ElevatedButton.styleFrom(
          primary: CharactersColors.greenAccent,
        ),
        child: Text('Detalle', style: CharactersTextStyles.robotoBold()),
        onPressed: () => characterTapped(widget.character.id),
      ),
    );
  }

  void characterTapped(int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ConcreteCharacterPage(characterId: id)),
    );
  }
}
