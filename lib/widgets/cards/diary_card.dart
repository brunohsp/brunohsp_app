import 'package:brunohsp_app/pages/note/note_update.dart';
import 'package:brunohsp_app/widgets/cards/default_card.dart';
import 'package:flutter/material.dart';

class DiaryCard extends DefaultCard {
  final String sectionName;
  final String content;
  final DateTime date;

  DiaryCard(
      {required columns,
      required this.sectionName,
      required this.content,
      required this.date,
      required context,
      Key? key})
      : super(
            key: key,
            columns: columns,
            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteUpdate(title: sectionName, date: date, note: content),
                  ),
                );
              },

            child: _DiaryCardChildren(
                sectionName: sectionName, date: date, content: content));
}

class _DiaryCardChildren extends StatelessWidget {
  final String sectionName;
  final String content;
  final DateTime date;
  const _DiaryCardChildren(
      {required this.sectionName,
      required this.content,
      required this.date,
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
                            sectionName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text('${date.day}/${date.month}/${date.year}',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold))
                      ]),
                ),
                Expanded(
                    flex: 1,
                    child: Text(
                      content,
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
