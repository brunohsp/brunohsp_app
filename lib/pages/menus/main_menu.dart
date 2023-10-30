import 'package:brunohsp_app/pages/character/character_form.dart';
import 'package:brunohsp_app/repositories/character_form_repository.dart';
import 'package:brunohsp_app/repositories/characters_repository.dart';
import 'package:brunohsp_app/repositories/dices_repository.dart';
import 'package:brunohsp_app/services/auth_service.dart';
import 'package:brunohsp_app/widgets/cards/default_card.dart';
import 'package:brunohsp_app/widgets/cards/mini_rolled_dice_card.dart';
import 'package:brunohsp_app/widgets/cards/mini_sheet_card.dart';
import 'package:brunohsp_app/widgets/cards/new_item_card.dart';
import 'package:brunohsp_app/widgets/utils/section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  late CharacterRepository charactersRepository;
  late DicesRepository dicesReposository;

  wrapSheets() {
    return Section(
      title: 'Fichas',
      child: SizedBox(
          height: 160,
          child: Consumer<CharacterRepository>(
              builder: (context, characters, child) {
            return characters.list.isEmpty
                ? NewItemCard(
                    columns: 3,
                    itemName: 'Personagem',
                    onTap: () {
                      return Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                              create: (context) => CharacterFormRepository(
                                  auth: context.read<AuthService>()),
                              child: const CharacterForm()),
                        ),
                      );
                    },
                  )
                : SizedBox(
                    height: 300,
                    child: ListView.builder(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      itemCount: characters.list.length,
                      itemBuilder: (_, index) {
                        return MiniSheetCard(
                          columns: 3,
                          character: characters.list[index],
                        );
                      },
                    ),
                  );
          })),
    );
  }

  wrapDices() {
    // TODO: INSERT DATABASE
    return Section(
      title: 'Dados Rolados Recentemente',
      child: SizedBox(
        height: 152,
        child: Consumer<DicesRepository>(
          builder: (context, dices, child) {
            return dices.list.isEmpty
                ? DefaultCard(
                    columns: 3,
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text('Nenhum dado foi jogado ainda...'),
                    ),
                  )
                : ListView.builder(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    itemCount: dices.list.length,
                    itemBuilder: (_, index) {
                      return MiniRolledDiceCard(
                        onTap: () async =>
                            await dicesReposository.remove(dices.list[index]),
                        columns: 3,
                        diceRoll: dices.list[index],
                      );
                    },
                  );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    charactersRepository = context.watch<CharacterRepository>();
    dicesReposository = context.watch<DicesRepository>();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => charactersRepository.refresh(),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            wrapSheets(),
            wrapDices(),
          ],
        ),
      ),
    );
  }
}
