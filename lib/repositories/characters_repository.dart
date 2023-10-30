import 'dart:collection';
import 'dart:io';

import 'package:brunohsp_app/database/db_firestore.dart';
import 'package:brunohsp_app/models/character.dart';
import 'package:brunohsp_app/models/dnd_class.dart';
import 'package:brunohsp_app/models/resistance.dart';
import 'package:brunohsp_app/models/skill.dart';
import 'package:brunohsp_app/services/auth_service.dart';
import 'package:brunohsp_app/services/class_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CharacterRepository extends ChangeNotifier {
  final List<Character> _list = [];
  late FirebaseFirestore db;
  final FirebaseStorage storage = FirebaseStorage.instance;

  late AuthService auth;

  CharacterRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readCharacters();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _getImage(String? imageId) async {
    if (imageId == null) return null;
    return await storage.ref('images/$imageId').getDownloadURL();
  }

  _readCharacters() async {
    if (auth.user != null && _list.isEmpty) {
      try {
        final snapshot =
            await db.collection('users/${auth.user!.uid}/characters').get();

        for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
          String id = doc.get('id');

          Resistance resistance = await _getResistances(id) as Resistance;

          Skill skill = await _getSkills(id, resistance) as Skill;

          _list.add(Character.withResistancesAndSkills(
            id: id,
            name: doc.get('name'),
            dndClass: await _getDndClass(doc.get('dnd_class')),
            level: doc.get('level'),
            hp: doc.get('hp'),
            armor: doc.get('armor'),
            proficiency: doc.get('proficiency'),
            resistances: resistance,
            skills: skill,
            imageUrl: await _getImage(doc.get('image_id')),
            imageId: doc.get('image_id')
          ));
        }
        notifyListeners();
      } catch (e) {
        debugPrint('CHARACTERS_REPOSITORY_ERROR: ${e.toString()}');
      }
    }
  }

  refresh() async {
    _list.clear();
    await _readCharacters();
  }

  Future<DndClass> _getDndClass(dndClass) async {
    DndClassService service = DndClassService();

    return await service.getByIndex(dndClass);
  }

  Future<Resistance?> _getResistances(id) async {
    try {
      final doc = await db
          .collection('users/${auth.user!.uid}/resistances')
          .doc(id)
          .get();

      Resistance resistance = Resistance(
        strength: doc.get('strength'),
        inteligency: doc.get('inteligency'),
        dexterity: doc.get('dexterity'),
        wisdom: doc.get('wisdom'),
        constitution: doc.get('constitution'),
        charism: doc.get('charism'),
      );
      resistance.proficiencies =
          Resistance.resistancesFromFirestore(doc.get('proficiencies'));

      return resistance;
    } catch (e) {
      debugPrint('RESISTANCE_CHARACTERS_REPOSITORY_ERROR: ${e.toString()}');
      return null;
    }
  }

  Future<Skill?> _getSkills(String id, Resistance resistance) async {
    try {
      final doc =
          await db.collection('users/${auth.user!.uid}/skills').doc(id).get();

      Skill skill = Skill(
        resistance: resistance,
        proficiencies: Skill.skillsFromFirestore(doc.get('proficiencies')),
      );
      return skill;
    } catch (e) {
      debugPrint('SKILL_CHARACTERS_REPOSITORY_ERROR: ${e.toString()}');
      return null;
    }
  }

  UnmodifiableListView<Character> get list => UnmodifiableListView(_list);

  removeImage(String imageUrl) async {
    await storage.refFromURL(imageUrl).delete();
  }

  saveImage(Map<String, dynamic> imageInfos) async {
    File file = File(imageInfos["image"].path);
    try {
      String ref = 'images/${imageInfos["id"]}';
      final storageRef = FirebaseStorage.instance.ref();
      storageRef.child(ref).putFile(
            file,
            SettableMetadata(
              cacheControl: "public, max-age=300",
              contentType: "image/jpeg",
              customMetadata: {
                "user": auth.user!.uid,
              },
            ),
          );
      notifyListeners();
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload: ${e.code}');
    }
  }

  _saveCharacter(newCharacter) async {
    await db
        .collection('users/${auth.user!.uid}/characters')
        .doc(newCharacter.id)
        .set({
      'id': newCharacter.id,
      'name': newCharacter.name,
      'dnd_class': newCharacter.dndClass.index,
      'level': newCharacter.level,
      'hp': newCharacter.hp,
      'armor': newCharacter.armor,
      'proficiency': newCharacter.proficiency,
      'image_id': newCharacter.imageInfos["id"],
    });
  }

  _saveResistances(newCharacter) async {
    await db
        .collection('users/${auth.user!.uid}/resistances')
        .doc(newCharacter.id)
        .set({
      'strength': newCharacter.resistances.strength,
      'inteligency': newCharacter.resistances.inteligency,
      'dexterity': newCharacter.resistances.dexterity,
      'wisdom': newCharacter.resistances.wisdom,
      'constitution': newCharacter.resistances.constitution,
      'charism': newCharacter.resistances.charism,
      'proficiencies': newCharacter.resistances.proficiencies.toString(),
    });
  }

  _saveSkills(newCharacter) async {
    await db
        .collection('users/${auth.user!.uid}/skills')
        .doc(newCharacter.id)
        .set({
      'proficiencies': newCharacter.skills.proficiencies.toString(),
    });
  }

  saveOneCharacter(Character newCharacter) async {
    UniqueKey key = UniqueKey();
    newCharacter.id =
        newCharacter.id == 'null' ? key.toString() : newCharacter.id;

    _list.add(newCharacter);

    await _saveCharacter(newCharacter);
    await _saveResistances(newCharacter);
    await _saveSkills(newCharacter);

    notifyListeners();
  }

  remove(Character character) async {
    if (character.imageUrl != null)
      await removeImage(character.imageUrl as String);

    await db
        .collection('users/${auth.user!.uid}/characters')
        .doc(character.id)
        .delete();

    await db
        .collection('users/${auth.user!.uid}/resistances')
        .doc(character.id)
        .delete();

    await db
        .collection('users/${auth.user!.uid}/skills')
        .doc(character.id)
        .delete();

    _list.remove(character);
    notifyListeners();
  }
}
