import 'package:brunohsp_app/models/dnd_class.dart';
import 'package:brunohsp_app/models/resistance.dart';
import 'package:brunohsp_app/models/skill.dart';

class Character {
  final Map<String, dynamic> imageInfos = {'id': null,'image': null };
  late String? imageUrl;
  late String id;
  late String name;
  late int level;
  late int hp;
  late int armor;
  late int proficiency;
  late DndClass dndClass;
  late Resistance resistances;
  late Skill skills;

  Character({
    required this.name,
    required this.level,
    required this.hp,
    required this.armor,
    required this.proficiency,
  });

  Character.withResistancesAndSkills({
    required this.id,
    required this.name,
    required this.dndClass,
    required this.level,
    required this.hp,
    required this.armor,
    required this.proficiency,
    required this.resistances,
    required this.skills,
    this.imageUrl,
    imageId,
  }){
    imageInfos["id"] = imageId;
  }

  Character.emptyInstance() {
    proficiency = 0;
    level = 1;
    hp = 1;
    armor = 0;
    imageUrl = null;
    id = 'null';
  }
}
