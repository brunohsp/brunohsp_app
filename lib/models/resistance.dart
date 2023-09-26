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
  late List<Resistances> proeficiencies;

  Resistance(
    this.strength,
    this.inteligency,
    this.dexterity,
    this.wisdom,
    this.constitution,
    this.charism,
  );
}
