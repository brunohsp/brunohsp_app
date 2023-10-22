import 'package:brunohsp_app/models/resistance.dart';

enum Skills {
  acrobatics,
  performance,
  arcana,
  athletics,
  deception,
  animalHandling,
  history,
  sleightOfHand,
  intimidation,
  insight,
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
  late Resistance resistance;
  late int acrobatics;
  late int performance;
  late int arcana;
  late int athletics;
  late int deception;
  late int animalHandling;
  late int history;
  late int sleightOfHand;
  late int intimidation;
  late int insight;
  late int investigation;
  late int medicine;
  late int nature;
  late int perception;
  late int persuation;
  late int religion;
  late int stealth;
  late int survival;
  late List<Skills> proficiencies;

  Skill({required this.resistance, required this.proficiencies, int bonus = 0}) {
    athletics = calculateSkill(resistance.strength);

    acrobatics = calculateSkill(resistance.dexterity);
    stealth = calculateSkill(resistance.dexterity);
    sleightOfHand = calculateSkill(resistance.dexterity);

    performance = calculateSkill(resistance.charism);
    deception = calculateSkill(resistance.charism);
    intimidation = calculateSkill(resistance.charism);
    persuation = calculateSkill(resistance.charism);

    arcana = calculateSkill(resistance.inteligency);
    history = calculateSkill(resistance.inteligency);
    investigation = calculateSkill(resistance.inteligency);
    nature = calculateSkill(resistance.inteligency);
    religion = calculateSkill(resistance.inteligency);

    animalHandling = calculateSkill(resistance.wisdom);
    insight = calculateSkill(resistance.wisdom);
    medicine = calculateSkill(resistance.wisdom);
    perception = calculateSkill(resistance.wisdom);
    survival = calculateSkill(resistance.wisdom);

    validateProficiencies(bonus);
  }

  Skill.udpateValues({
    required this.acrobatics,
    required this.arcana,
    required this.athletics,
    required this.performance,
    required this.deception,
    required this.stealth,
    required this.history,
    required this.intimidation,
    required this.insight,
    required this.investigation,
    required this.animalHandling,
    required this.medicine,
    required this.nature,
    required this.perception,
    required this.persuation,
    required this.sleightOfHand,
    required this.religion,
    required this.survival,
  });

  void validateProficiencies(int bonus) {
    athletics += proficiencies.contains(Skills.athletics) ? bonus : 0;
    acrobatics += proficiencies.contains(Skills.acrobatics) ? bonus : 0;
    stealth += proficiencies.contains(Skills.stealth) ? bonus : 0;
    sleightOfHand += proficiencies.contains(Skills.sleightOfHand) ? bonus : 0;
    performance += proficiencies.contains(Skills.performance) ? bonus : 0;
    deception += proficiencies.contains(Skills.deception) ? bonus : 0;
    intimidation += proficiencies.contains(Skills.intimidation) ? bonus : 0;
    persuation += proficiencies.contains(Skills.persuation) ? bonus : 0;
    arcana += proficiencies.contains(Skills.arcana) ? bonus : 0;
    history += proficiencies.contains(Skills.history) ? bonus : 0;
    investigation += proficiencies.contains(Skills.investigation) ? bonus : 0;
    nature += proficiencies.contains(Skills.nature) ? bonus : 0;
    religion += proficiencies.contains(Skills.religion) ? bonus : 0;
    animalHandling += proficiencies.contains(Skills.animalHandling) ? bonus : 0;
    insight += proficiencies.contains(Skills.insight) ? bonus : 0;
    medicine += proficiencies.contains(Skills.medicine) ? bonus : 0;
    perception += proficiencies.contains(Skills.perception) ? bonus : 0;
    survival += proficiencies.contains(Skills.survival) ? bonus : 0;
  }

  int calculateSkill(int value) {
    switch (value) {
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

  static Skills? translateSkill(Map<String, dynamic> proficiency) {
    switch (proficiency["index"]) {
      case 'skill-acrobatics':
        return Skills.acrobatics;
      case 'skill-animal-handling':
        return Skills.animalHandling;
      case 'skill-arcana':
        return Skills.arcana;
      case 'skill-athletics':
        return Skills.athletics;
      case 'skill-deception':
        return Skills.deception;
      case 'skill-history':
        return Skills.history;
      case 'skill-insight':
        return Skills.insight;
      case 'skill-intimidation':
        return Skills.intimidation;
      case 'skill-investigation':
        return Skills.investigation;
      case 'skill-medicine':
        return Skills.medicine;
      case 'skill-nature':
        return Skills.nature;
      case 'skill-perception':
        return Skills.perception;
      case 'skill-performance':
        return Skills.performance;
      case 'skill-persuation':
        return Skills.persuation;
      case 'skill-religion':
        return Skills.religion;
      case 'skill-sleight-of-hand':
        return Skills.sleightOfHand;
      case 'skill-stealth':
        return Skills.stealth;
      case 'skill-survival':
        return Skills.survival;
    }
    return null;
  }

  static List<Skills> fromListMap(List<dynamic> list) {
    List<Skills> proficienciesTranslated = [];

    for (Map<String, dynamic> item in list) {
      Skills? skill = Skill.translateSkill(item["item"]);
      if (skill != null) proficienciesTranslated.add(skill);
    }

    return proficienciesTranslated;
  }
}
