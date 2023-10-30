import 'package:brunohsp_app/models/character.dart';
import 'package:brunohsp_app/widgets/cards/default_card.dart';
import 'package:brunohsp_app/widgets/utils/tag.dart';
import 'package:flutter/material.dart';

class MiniSheetCard extends DefaultCard {
  final Character character;

  MiniSheetCard({required columns, required this.character, Key? key})
      : super(
            key: key,
            columns: columns,
            child: _MiniSheetCardChildren(
              character: character,
            ));
}

class _MiniSheetCardChildren extends StatelessWidget {
  final Character character;

  const _MiniSheetCardChildren(
      {required this.character,
      Key? key})
      : super(key: key);

  headerBuilder() {
    String? url = character.imageUrl;
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
            radius: 24,
            backgroundImage: url != null
                ? Image.network(url, fit: BoxFit.cover).image
                : null,
          ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 0,
                  child: Text(
                    character.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  character.dndClass.name,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  bottomBuilder() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('nvl. ${character.level}'),
          Tag(
              badge: const Icon(
                Icons.favorite_rounded,
                size: 16,
              ),
              label: character.hp.toString()),
          Tag(
              badge: const Icon(
                Icons.shield_rounded,
                size: 16,
              ),
              label: character.armor.toString()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        headerBuilder(),
        bottomBuilder(),
      ],
    );
  }
}
