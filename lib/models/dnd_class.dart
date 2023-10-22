import 'package:brunohsp_app/models/resistance.dart';
import 'package:brunohsp_app/models/skill.dart';

class DndClass {
  late String index;
  late String name;
  late int hitDie;
  late List<Resistances> savingThrows = [];
  late List<Skills> possibleSkills = [];
  late Map<int, int> profBonusesBylevel = {};
  late int maxResistances;

  DndClass();
  DndClass.withInfos({required this.index, required this.name});
  DndClass.fromMap(Map<String, dynamic> map)
      : index = map["index"],
        name = map["name"];

  void specificationsFromMap(
      Map<String, dynamic> classMap, List<dynamic> levelsMap) async {
    index = classMap["index"];
    name = classMap["name"];
    hitDie = classMap["hit_die"];
    List<dynamic> proficiencies = classMap["proficiency_choices"];

    savingThrows = Resistance.fromListMap(classMap["saving_throws"]);

    for (Map<String, dynamic> proficiencie in proficiencies) {
      maxResistances = proficiencie["choose"];

      possibleSkills = Skill.fromListMap(proficiencie["from"]["options"]);
    }

    for (Map<String, dynamic> level in levelsMap) {
      profBonusesBylevel[level["level"]] = level["prof_bonus"];
    }
  }
}
