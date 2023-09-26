import 'package:brunohsp_app/widgets/cards/mini_rolled_dice_card.dart';
import 'package:brunohsp_app/widgets/cards/mini_sheet_card.dart';
import 'package:brunohsp_app/widgets/utils/section.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  wrapSheets() {
    return Section(
      title: 'Fichas',
      child: SizedBox(
        height: 160,
        child: ListView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          children: [
            MiniSheetCard(
              columns: 3,
              name: 'João das Neves DA SILVAdasdadasdasdadsad',
              playerClass: 'Nerd',
              level: 13,
              hp: 10,
              armor: 0,
            ),
            MiniSheetCard(
              columns: 3,
              name: 'João das Neves DA SILVAdasdadasdasdadsad',
              playerClass: 'Nerd',
              level: 13,
              hp: 10,
              armor: 0,
            ),
            MiniSheetCard(
              columns: 3,
              name: 'João das Neves DA SILVAdasdadasdasdadsad',
              playerClass: 'Nerd',
              level: 13,
              hp: 10,
              armor: 0,
            ),
          ],
        ),
      ),
    );
  }



  wrapDices() {
    return Section(
      title: 'Dados Rolados Recentemente',
      child: SizedBox(
        height: 152,
        child: ListView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          children: [
            MiniRolledDiceCard(
              columns: 3,
              dice: 'D20',
              results: const [10],
            ),
            MiniRolledDiceCard(
              columns: 3,
              times: 4,
              addition: 1,
              dice: 'D20',
              results: const [10, 20, 3, 12],
            ),
            MiniRolledDiceCard(
              columns: 3,
              times: 2,
              addition: 4,
              dice: 'D20',
              results: const [10, 3],
            ),
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
          'Menu Inicial',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [wrapSheets(), wrapDices()],
      ),
    );
  }
}
