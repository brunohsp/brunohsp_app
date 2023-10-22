import 'package:brunohsp_app/models/character.dart';
import 'package:brunohsp_app/models/dnd_class.dart';
import 'package:brunohsp_app/models/resistance.dart';
import 'package:brunohsp_app/models/skill.dart';
import 'package:flutter/material.dart';

class CharacterFormRepository extends ChangeNotifier {
  final Character _newCharacter = Character.emptyInstance();
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

  savingBySteps(int step, Map<String, TextEditingController> controllers) {
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
        _newCharacter.skills = Skill.udpateValues(
          acrobatics: int.parse(controllers["acrobatics"]!.text),
          arcana: int.parse(controllers["arcana"]!.text),
          athletics: int.parse(controllers["athletics"]!.text),
          performance: int.parse(controllers["performance"]!.text),
          deception: int.parse(controllers["deception"]!.text),
          stealth: int.parse(controllers["stealth"]!.text),
          history: int.parse(controllers["history"]!.text),
          intimidation: int.parse(controllers["intimidation"]!.text),
          insight: int.parse(controllers["insight"]!.text),
          investigation: int.parse(controllers["investigation"]!.text),
          animalHandling: int.parse(controllers["animalHandling"]!.text),
          medicine: int.parse(controllers["medicine"]!.text),
          nature: int.parse(controllers["nature"]!.text),
          perception: int.parse(controllers["perception"]!.text),
          persuation: int.parse(controllers["persuation"]!.text),
          sleightOfHand: int.parse(controllers["sleightOfHand"]!.text),
          religion: int.parse(controllers["religion"]!.text),
          survival: int.parse(controllers["survival"]!.text),
        );

        super.dispose();
        break;
    }
  }
}
