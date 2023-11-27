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

  static List<Resistances> resistancesFromFirestore(String data) {
    if(data == '[]') return List<Resistances>.empty();

    data = data.replaceAll('Resistances.', '');
    data = data.replaceAll('[', '');
    data = data.replaceAll(']', '');
    List<String> resistances = data.split(',');

    List<Resistances> translated = [];


    for (String element in resistances) {
      translated.add(Resistance.translateProficiency(element.trim().substring(0, 3))
          as Resistances);
    }

    return translated;
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
