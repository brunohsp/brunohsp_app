import 'package:brunohsp_app/models/resistance.dart';
import 'package:brunohsp_app/models/skill.dart';

class Character {
  final String name;
  final String playerClass;
  final int level;
  final int hp;
  final int armor;
  final int proeficiency;
  late Resistance resistances;
  late Skill skills;

  Character({
    required this.name,
    required this.playerClass,
    required this.level,
    required this.hp,
    required this.armor,
    required this.proeficiency,
  });

   Character.withResistancesAndSkills({
    required this.name,
    required this.playerClass,
    required this.level,
    required this.hp,
    required this.armor,
    required this.proeficiency,
    required this.resistances,
    required this.skills,
  });
}
