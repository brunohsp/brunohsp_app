import 'dart:collection';

import 'package:brunohsp_app/database/db_firestore.dart';
import 'package:brunohsp_app/models/note.dart';
import 'package:brunohsp_app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotesRepository extends ChangeNotifier {
  final List<Note> _list = [];
  late FirebaseFirestore db;
  late AuthService auth;

  NotesRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readNotes();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readNotes() async {
    if (auth.user != null && _list.isEmpty) {
      try {
        final snapshot =
            await db.collection('users/${auth.user!.uid}/notes').get();

        for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
          _list.add(
            Note(
              sectionName: doc.get('section_name'),
              content: doc.get('content'),
              date: DateTime.parse(doc.get('date').toDate().toString()),
            ),
          );
        }
        notifyListeners();
      } catch (e) {
        debugPrint('NOTES_REPOSITORY_ERROR: ${e.toString()}');
      }
    }
  }

  UnmodifiableListView<Note> get list => UnmodifiableListView(_list);

  saveOneNote(Note newNote) async {
    _list.add(newNote);

    await db
        .collection('users/${auth.user!.uid}/notes')
        .doc('${newNote.date}_${newNote.sectionName}')
        .set({
      'section_name': newNote.sectionName,
      'content': newNote.content,
      'date': newNote.date
    });
    notifyListeners();
  }

  remove(Note note) async {
    await db
        .collection('users/${auth.user!.uid}/notes')
        .doc('${note.date}_${note.sectionName}')
        .delete();
    _list.remove(note);
    notifyListeners();
  }
}
