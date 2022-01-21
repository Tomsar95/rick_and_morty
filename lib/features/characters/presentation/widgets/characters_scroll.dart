import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/utils/characters_text_styles.dart';
import 'package:rick_and_morty/core/utils/characters_colors.dart';
import 'package:rick_and_morty/core/utils/helper_functions.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';

class CharactersScroll extends StatefulWidget {
  final List<Character> characters;

  const CharactersScroll({Key? key, required this.characters})
      : super(key: key);

  @override
  _CharactersScrollState createState() => _CharactersScrollState();
}

class _CharactersScrollState extends State<CharactersScroll> {
  @override
  Widget build(BuildContext context) {
    List<Widget> sliverList = [];
    sliverList.add(SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        return CharacterTile(
          character: widget.characters[index],
        );
      },
      childCount: widget.characters.length,
    )));
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      slivers: sliverList,
    );
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
                      Text(widget.character.name,
                          style: CharactersTextStyles.robotoBold()),
                      buildStatus(),
                      Text(
                        widget.character.species,
                        style: CharactersTextStyles.robotoRegular(),
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
    return ClipRRect(
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
              ))),
        ),
      ),
    );
  }

  Widget buildStatus() {
    return Row(
      children: [
        ClipRRect(
            borderRadius:
            const BorderRadius.all(Radius.circular(7)),
            child: Container(
              height: 14,
              width: 14,
              color: HelperFunctions.characterIsAlive(
                  widget.character.status)
                  ? CharactersColors.greenAccent
                  : CharactersColors.darkGray,
            )),
        const SizedBox(
          width: 8,
        ),
        Text(
          widget.character.status,
          style: CharactersTextStyles.robotoRegular(),
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
        child: Text('Detalle',
            style: CharactersTextStyles.robotoBold()),
        onPressed: () {},
      ),
    );
  }
}
