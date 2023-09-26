import 'package:brunohsp_app/models/resistance.dart';

enum Skills{
  acrobacy,
actuation,
arcanism,
athletism,
bluff,
handleWithAnimals,
history,
ilusion,
intimidation,
intuition,
investigation,
medicine,
nature,
perception,
persuation,
religion,
stealth,
survival,
}

class Skill {
  final Resistance resistance;
  late int acrobacy;
  late int actuation;
  late int arcanism;
  late int athletism;
  late int bluff;
  late int handleWithAnimals;
  late int history;
  late int ilusion;
  late int intimidation;
  late int intuition;
  late int investigation;
  late int medicine;
  late int nature;
  late int perception;
  late int persuation;
  late int religion;
  late int stealth;
  late int survival;
  late List<Skills> proeficiencies;

  Skill({required this.resistance}){
    athletism = calculateSkill(resistance.strength);

    acrobacy = calculateSkill(resistance.dexterity);
    stealth = calculateSkill(resistance.dexterity);
    ilusion = calculateSkill(resistance.dexterity);

    actuation = calculateSkill(resistance.charism);
    bluff = calculateSkill(resistance.charism);
    intimidation = calculateSkill(resistance.charism);
    persuation = calculateSkill(resistance.charism);

    arcanism = calculateSkill(resistance.inteligency);
    history = calculateSkill(resistance.inteligency);
    investigation = calculateSkill(resistance.inteligency);
    nature = calculateSkill(resistance.inteligency);
    religion = calculateSkill(resistance.inteligency);

    handleWithAnimals = calculateSkill(resistance.wisdom);
    intuition = calculateSkill(resistance.wisdom);
    medicine = calculateSkill(resistance.wisdom);
    perception = calculateSkill(resistance.wisdom);
    survival = calculateSkill(resistance.wisdom);
  }

  int calculateSkill(int value) {
    switch(value){
      case >= 30:
        return 10;
      case >= 10:
        return (value - 10) ~/ 2;
      case < 10:
        return (value - 11) ~/ 2;
      default:
        return -5;
    }
  }

}
