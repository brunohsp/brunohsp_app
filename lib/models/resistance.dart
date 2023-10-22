enum Resistances {
  strength,
  intelligency,
  dexterity,
  wisdom,
  constitution,
  charism,
}

class Resistance {
  late int strength;
  late int inteligency;
  late int dexterity;
  late int wisdom;
  late int constitution;
  late int charism;
  late List<Resistances> proficiencies;

  Resistance({
    required this.strength,
    required this.inteligency,
    required this.dexterity,
    required this.wisdom,
    required this.constitution,
    required this.charism,
});

  @override
  String toString() {
    return "$strength/n$inteligency/n$dexterity/n$wisdom/n$constitution/n$charism/n";
  }

  static Resistances? translateProficiency(String proficiency) {
    switch (proficiency) {
      case 'cha':
        return Resistances.charism;

      case 'con':
        return Resistances.constitution;

      case 'dex':
        return Resistances.dexterity;

      case 'int':
        return Resistances.intelligency;

      case 'str':
        return Resistances.strength;

      case 'wis':
        return Resistances.wisdom;
    }
    return null;
  }

  static List<Resistances> fromListMap(List<dynamic> list) {
    List<Resistances> proficienciesTranslated = [];

    for (Map<String, dynamic> item in list) {
      Resistances? proficiencie =
          Resistance.translateProficiency(item["index"]);
      if (proficiencie != null) proficienciesTranslated.add(proficiencie);
    }

    return proficienciesTranslated;
  }
}
