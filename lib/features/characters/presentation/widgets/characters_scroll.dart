import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/Utils/characters_colors.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';

class CharactersScroll extends StatefulWidget {

  final List<Character> characters;

  const CharactersScroll({Key? key, required this.characters}) : super(key: key);


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
            return Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: CharacterTile(
                character: widget.characters[index],
              ),
            );
          },
          childCount: widget.characters.length,
        )));
    return Container();
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
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        color: CharactersColors.lightGray,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            builtImage(),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(widget.character.name),
                Text(widget.character.status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget builtImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: AspectRatio(
        aspectRatio: 1 / 1.3,
        child: CachedNetworkImage(
          imageUrl: widget.character.image,
          fit: BoxFit.fitWidth,
          placeholder: (context, url) => Container(
              color: CharactersColors.darkGray.withOpacity(0.1),
              child: const Center(child: CircularProgressIndicator(strokeWidth: 2,))),
        ),
      ),
    );
  }
}

