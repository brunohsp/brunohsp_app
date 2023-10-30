import 'package:brunohsp_app/models/note.dart';
import 'package:brunohsp_app/pages/note/note_form.dart';
import 'package:brunohsp_app/repositories/notes_repository.dart';
import 'package:brunohsp_app/widgets/cards/note_card.dart';
import 'package:brunohsp_app/widgets/cards/new_item_card.dart';
import 'package:brunohsp_app/widgets/avatars/dice_avatar.dart';
import 'package:brunohsp_app/widgets/utils/section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameplayMenu extends StatefulWidget {
  const GameplayMenu({Key? key}) : super(key: key);

  @override
  State<GameplayMenu> createState() => _GameplayMenuState();
}

class _GameplayMenuState extends State<GameplayMenu> {
  late List<Note> notes;
  late NotesRepository notesRepository;

  wrapDices() {
    // TODO: CHANGE WHERE THE DICES AR CODED - INHERITED_WIDGET
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

  wrapDiaries() {
    return Section(
      title: 'Diário do Jogador',
      iconButton: IconButton(
        icon: const Icon(Icons.add_circle_outline_rounded),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NoteForm(isCreate: true),
            ),
          );
        },
      ),
      child: SizedBox(
        height: 300,
        child: Consumer<NotesRepository>(builder: (context, notes, child) {
          return notes.list.isEmpty
              ? NewItemCard(
                  columns: 2,
                  itemName: 'Nota',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NoteForm(isCreate: true),
                      ),
                    );
                  },
                )
              : SizedBox(
                height: 300,
                child: ListView.builder(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  itemCount: notes.list.length,
                    itemBuilder: (_, index) {
                      return NoteCard(
                        context: context,
                        columns: 2,
                        note: notes.list[index],
                      );
                    },
                  ),
              );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    notesRepository = context.watch<NotesRepository>();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => notesRepository.refresh(),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [wrapDices(), wrapDiaries()],
        ),
      ),
    );
  }
}
