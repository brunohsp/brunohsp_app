import 'package:brunohsp_app/models/note.dart';
import 'package:brunohsp_app/pages/note/note_form.dart';
import 'package:brunohsp_app/widgets/cards/default_card.dart';
import 'package:flutter/material.dart';

class NoteCard extends DefaultCard {
  final Note note;

  NoteCard({required columns, required this.note, required context, Key? key})
      : super(
          key: key,
          columns: columns,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteForm(
                  isCreate: false,
                  selectedNote: note,
                ),
              ),
            );
          },
          child: _NoteCardChildren(
            note: note,
          ),
        );
}

class _NoteCardChildren extends StatelessWidget {
  final Note note;
  const _NoteCardChildren(
      {required this.note,
      Key? key})
      : super(key: key);

  headerBuilder() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 0,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            note.sectionName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text('${note.date.day}/${note.date.month}/${note.date.year}',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold))
                      ]),
                ),
                Expanded(
                    flex: 1,
                    child: Text(
                      note.content,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                      maxLines: 12,
                    ))
              ],
            ),
          ),
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
      ],
    );
  }
}
