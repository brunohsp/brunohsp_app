import 'package:brunohsp_app/models/character.dart';
import 'package:brunohsp_app/models/dnd_class.dart';
import 'package:brunohsp_app/models/resistance.dart';
import 'package:brunohsp_app/models/skill.dart';
import 'package:brunohsp_app/repositories/characters_repository.dart';
import 'package:brunohsp_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class CharacterFormRepository extends ChangeNotifier {
  final Character _newCharacter = Character.emptyInstance();
  late CharacterRepository characters;
  late AuthService auth;

  CharacterFormRepository({required this.auth}) {
    characters = CharacterRepository(auth: auth);
  }

  bool _isClassSelected = false;

  Character get newCharacter => _newCharacter;
  bool get isClassSelected => _isClassSelected;

  @override
  // ignore: must_call_super
  void dispose() {}

  saveClass(DndClass dndClass) {
    _newCharacter.dndClass = dndClass;
    _newCharacter.proficiency = _newCharacter.dndClass.profBonusesBylevel[1]!;
    _isClassSelected = true;
    notifyListeners();
  }

  changeLevel(int level) {
    _newCharacter.level = level;
    _newCharacter.proficiency =
        _newCharacter.dndClass.profBonusesBylevel[level]!;
  }

  changeHp(int hp) {
    _newCharacter.hp = hp;
  }

  changeArmor(int armor) {
    _newCharacter.armor = armor;
  }

  savingBySteps(
      int step, Map<String, TextEditingController> controllers) async {
    switch (step) {
      case 1:
        // level, class and proficiency being saved before button click
        _newCharacter.name = controllers["name"]!.text;
        _newCharacter.hp = int.parse(controllers["hp"]!.text);
        _newCharacter.armor = int.parse(controllers["armor"]!.text);

        break;
      case 2:
        _newCharacter.resistances = Resistance(
          strength: int.parse(controllers["strength"]!.text),
          inteligency: int.parse(controllers["inteligency"]!.text),
          dexterity: int.parse(controllers["dexterity"]!.text),
          wisdom: int.parse(controllers["wisdom"]!.text),
          constitution: int.parse(controllers["constitution"]!.text),
          charism: int.parse(controllers["charism"]!.text),
        );
        _newCharacter.resistances.proficiencies =
            _newCharacter.dndClass.savingThrows;
        _newCharacter.skills = Skill(
          resistance: _newCharacter.resistances,
          proficiencies: _newCharacter.dndClass.possibleSkills,
          bonus: _newCharacter.proficiency,
        );

        break;
      case 3:
        _newCharacter.skills.acrobatics =
            int.parse(controllers["acrobatics"]!.text);
        _newCharacter.skills.arcana = int.parse(controllers["arcana"]!.text);
        _newCharacter.skills.athletics =
            int.parse(controllers["athletics"]!.text);
        _newCharacter.skills.performance =
            int.parse(controllers["performance"]!.text);
        _newCharacter.skills.deception =
            int.parse(controllers["deception"]!.text);
        _newCharacter.skills.stealth = int.parse(controllers["stealth"]!.text);
        _newCharacter.skills.history = int.parse(controllers["history"]!.text);
        _newCharacter.skills.intimidation =
            int.parse(controllers["intimidation"]!.text);
        _newCharacter.skills.insight = int.parse(controllers["insight"]!.text);
        _newCharacter.skills.investigation =
            int.parse(controllers["investigation"]!.text);
        _newCharacter.skills.animalHandling =
            int.parse(controllers["animalHandling"]!.text);
        _newCharacter.skills.medicine =
            int.parse(controllers["medicine"]!.text);
        _newCharacter.skills.nature = int.parse(controllers["nature"]!.text);
        _newCharacter.skills.perception =
            int.parse(controllers["perception"]!.text);
        _newCharacter.skills.persuation =
            int.parse(controllers["persuation"]!.text);
        _newCharacter.skills.sleightOfHand =
            int.parse(controllers["sleightOfHand"]!.text);
        _newCharacter.skills.religion =
            int.parse(controllers["religion"]!.text);
        _newCharacter.skills.survival =
            int.parse(controllers["survival"]!.text);

        if (newCharacter.imageInfos["id"] != null) await characters.saveImage(newCharacter.imageInfos);

        await characters.saveOneCharacter(_newCharacter);

        super.dispose();
        break;
    }


  }
}
