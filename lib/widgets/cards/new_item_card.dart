import 'package:brunohsp_app/widgets/cards/default_card.dart';
import 'package:flutter/material.dart';

class NewItemCard extends DefaultCard {
  final String itemName;

  NewItemCard({
    required columns,
    required this.itemName,
    onTap,
    Key? key,
  }) : super(
          key: key,
          columns: columns,
          onTap: onTap,
          child: _NewItemCardChildren(itemName: itemName),
        );
}

class _NewItemCardChildren extends StatelessWidget {
  final String itemName;
  const _NewItemCardChildren({required this.itemName, Key? key})
      : super(key: key);

  childrenBuilder() {
    String text = 'Adicionar $itemName';

    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
            maxLines: 2,
          ),
          const Icon(Icons.add),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        childrenBuilder(),
      ],
    );
  }
}
