import 'package:brunohsp_app/widgets/cards/default_card.dart';
import 'package:flutter/material.dart';

class MiniRolledDiceCard extends DefaultCard {
  final String dice;
  final int times;
  final int addition;
  final List<int> results;

  MiniRolledDiceCard(
      {required columns,
      required this.dice,
      this.times = 1,
      this.addition = 0,
      required this.results,
      Key? key})
      : super(
            key: key,
            columns: columns,
            child: _MiniRolledDiceCardChildren(
              dice: dice,
              times: times,
              addition: addition,
              results: results,
            ));
}

class _MiniRolledDiceCardChildren extends StatelessWidget {
  final String dice;
  final int times;
  final int addition;
  final List<int> results;

  const _MiniRolledDiceCardChildren(
      {required this.dice,
      required this.results,
      required this.times,
      required this.addition,
      Key? key})
      : super(key: key);

  headerBuilder() {
    String diceText =
        addition > 0 ? '$times$dice + $addition' : '$times$dice';

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
                    diceText,
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
          Text(results.toString()),
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
