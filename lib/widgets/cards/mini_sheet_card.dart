import 'package:brunohsp_app/widgets/cards/default_card.dart';
import 'package:brunohsp_app/widgets/utils/tag.dart';
import 'package:flutter/material.dart';

class MiniSheetCard extends DefaultCard {
  final String name;
  final String playerClass;
  final int level;
  final int hp;
  final int armor;

  MiniSheetCard(
      {required columns,
      required this.name,
      required this.playerClass,
      required this.level,
      required this.hp,
      required this.armor,
      Key? key})
      : super(
            key: key,
            columns: columns,
            child: _MiniSheetCardChildren(
                name: name,
                playerClass: playerClass,
                level: level,
                hp: hp,
                armor: armor));
}

class _MiniSheetCardChildren extends StatelessWidget {
  final String name;
  final String playerClass;
  final int level;
  final int hp;
  final int armor;
  const _MiniSheetCardChildren(
      {required this.name,
      required this.playerClass,
      required this.level,
      required this.hp,
      required this.armor,
      Key? key})
      : super(key: key);

  headerBuilder() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: CircleAvatar(radius: 24),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 0,
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  playerClass,
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
          Text('nvl. $level'),
          Tag(
              badge: const Icon(
                Icons.favorite_rounded,
                size: 16,
              ),
              label: hp.toString()),
          Tag(
              badge: const Icon(
                Icons.shield_rounded,
                size: 16,
              ),
              label: armor.toString()),
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
