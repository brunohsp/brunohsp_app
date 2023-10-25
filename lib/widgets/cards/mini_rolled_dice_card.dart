import 'package:brunohsp_app/models/dice_roll.dart';
import 'package:brunohsp_app/widgets/cards/default_card.dart';
import 'package:flutter/material.dart';

class MiniRolledDiceCard extends DefaultCard {
  final DiceRoll diceRoll;

  MiniRolledDiceCard(
      {required columns,
      required this.diceRoll,
      onTap,
      Key? key})
      : super(
            key: key,
            columns: columns,
            onTap: onTap,
            child: _MiniRolledDiceCardChildren(
              diceRoll: diceRoll,
            ));
}

class _MiniRolledDiceCardChildren extends StatelessWidget {
    final DiceRoll diceRoll;

  const _MiniRolledDiceCardChildren(
      {required this.diceRoll,
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
              child: CircleAvatar(radius: 24)),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 0,
                  child: Text(
                    diceRoll.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
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
          Text(diceRoll.results.toString()),
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
