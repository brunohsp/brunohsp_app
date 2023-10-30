import 'package:brunohsp_app/pages/character/character_form.dart';
import 'package:brunohsp_app/repositories/character_form_repository.dart';
import 'package:brunohsp_app/repositories/characters_repository.dart';
import 'package:brunohsp_app/services/auth_service.dart';
import 'package:brunohsp_app/widgets/cards/new_item_card.dart';
import 'package:brunohsp_app/widgets/cards/sheet_card.dart';
import 'package:brunohsp_app/widgets/utils/section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SheetsMenu extends StatefulWidget {
  const SheetsMenu({Key? key}) : super(key: key);

  @override
  State<SheetsMenu> createState() => _SheetsMenuState();
}

class _SheetsMenuState extends State<SheetsMenu> {
  late CharacterRepository charactersRepository;

  wrapSheets() {
    return Section(
      title: 'Fichas',
      iconButton: IconButton(
        icon: const Icon(Icons.add_circle_outline_rounded),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                  create: (context) => CharacterFormRepository(
                      auth: context.read<AuthService>()),
                  child: const CharacterForm()),
            ),
          );
        },
      ),
      child: SizedBox(
          height: 574,
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
                        return SheetCard(
                          context: context,
                          columns: 3,
                          character: characters.list[index],
                        );
                      },
                    ),
                  );
          })),
    );
  }

  @override
  Widget build(BuildContext context) {
    charactersRepository = context.read<CharacterRepository>();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await charactersRepository.refresh();
        },
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [wrapSheets()],
        ),
      ),
    );
  }
}
