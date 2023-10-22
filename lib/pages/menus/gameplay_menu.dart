import 'package:brunohsp_app/pages/note/new_note_register.dart';
import 'package:brunohsp_app/widgets/cards/diary_card.dart';
import 'package:brunohsp_app/widgets/cards/new_item_card.dart';
import 'package:brunohsp_app/widgets/avatars/dice_avatar.dart';
import 'package:brunohsp_app/widgets/utils/section.dart';
import 'package:flutter/material.dart';

class GameplayMenu extends StatefulWidget {
  const GameplayMenu({Key? key}) : super(key: key);

  @override
  State<GameplayMenu> createState() => _GameplayMenuState();
}

class _GameplayMenuState extends State<GameplayMenu> {
  wrapDices() { // TODO: CHANGE WHERE THE DICES AR CODED - INHERITED_WIDGET
    return Section(
      title: 'Dados',
      child: SizedBox(
        height: 72,
        child: ListView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          children: [
            DiceAvatar(
              url: 'assets/icons/diceIcons/d4.svg',
              sides: 4,
              color: Colors.deepOrange.shade400,
            ),
            DiceAvatar(
              url: 'assets/icons/diceIcons/d6.svg',
              sides: 6,
              color: Colors.deepOrange.shade500,
            ),
            DiceAvatar(
              url: 'assets/icons/diceIcons/d8.svg',
              sides: 8,
              color: Colors.red.shade600,
            ),
            DiceAvatar(
              url: 'assets/icons/diceIcons/d10.svg',
              sides: 10,
              color: Colors.redAccent.shade700,
            ),
            DiceAvatar(
              url: 'assets/icons/diceIcons/d12.svg',
              sides: 12,
              color: Colors.purple.shade800,
            ),
            DiceAvatar(
              url: 'assets/icons/diceIcons/d20.svg',
              sides: 20,
              color: Colors.deepPurple.shade900,
            ),
          ],
        ),
      ),
    );
  }

  wrapDiaries() { // TODO: INSERT DATABASE
    return Section(
      title: 'Diário do Jogador',
      child: SizedBox(
        height: 300,
        child: ListView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          children: [
            DiaryCard(
              context: context,
              columns: 2,
              sectionName: 'TEST',
              content:
                  'Lorem ipsum dolor sit amet consectetur. Consequat sed nam vel hendrerit ac ultrices. Eu lorem nisl integer est erat. Mauris sapien arcu ipsum ut nibh nam nibh pharetra in. Lorem ipsum dolor sit amet consectetur. Consequat sed nam vel hendrerit ac ultrices. Eu lorem nisl integer est erat. Mauris sapien arcu ipsum ut nibh nam nibh pharetra in. Lorem ipsum dolor sit amet consectetur. Consequat sed nam vel hendrerit ac ultrices. Eu lorem nisl integer est erat. Mauris sapien arcu ipsum ut nibh nam nibh pharetra in. Lorem ipsum dolor sit amet consectetur. Consequat sed nam vel hendrerit ac ultrices. Eu lorem nisl integer est erat. Mauris sapien arcu ipsum ut nibh nam nibh pharetra in.',
              date: DateTime.now(),
            ),
            NewItemCard(
              columns: 2,
              itemName: 'Nota',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewNoteRegister(),
                  ),
                );
              },
            ),
            // NewItemCard(columns: 2, height: 300.0, itemName: 'Notas')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gameplay',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [wrapDices(), wrapDiaries()],
      ),
    );
  }
}
