class DiceRoll {
  final String dice;
  final int times;
  final int addition;
  final List<int> results;

  DiceRoll(
      {required this.dice,
      required this.times,
      required this.addition,
      required this.results});

  @override
  String toString() {
    return addition > 0 ? '$times$dice + $addition' : '$times$dice';
  }
}
