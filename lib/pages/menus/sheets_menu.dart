import 'package:brunohsp_app/models/character.dart';
import 'package:brunohsp_app/models/resistance.dart';
import 'package:brunohsp_app/models/skill.dart';
import 'package:brunohsp_app/pages/character/new_character_register.dart';
import 'package:brunohsp_app/widgets/cards/new_item_card.dart';
import 'package:brunohsp_app/widgets/cards/sheet_card.dart';
import 'package:brunohsp_app/widgets/utils/section.dart';
import 'package:flutter/material.dart';

class SheetsMenu extends StatefulWidget {
  const SheetsMenu({Key? key}) : super(key: key);

  @override
  State<SheetsMenu> createState() => _SheetsMenuState();
}

class _SheetsMenuState extends State<SheetsMenu> {
  wrapSheets() {
    return Section(
      title: 'Fichas',
      child: SizedBox(
        height: 574,
        child: ListView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          children: [
            SheetCard(
              context: context,
              columns: 3,
              character: Character.withResistancesAndSkills(
                name: 'name',
                playerClass: 'playerClass',
                level: 10,
                hp: 10,
                armor: 10,
                proeficiency: 2,
                resistances: Resistance(10, 20, 13, 7, 4, 18),
                skills: Skill(
                  resistance: Resistance(10, 20, 13, 7, 4, 18),
                ),
              ),
            ),

            NewItemCard(
              columns: 2,
              itemName: 'Personagem',
              onTap: () {
                return Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewCharacterRegister(),
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
          'Personagens',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [wrapSheets()],
      ),
    );
  }
}
