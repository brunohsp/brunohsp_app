import 'dart:math';

class DiceAvatarController {
  static List<int> throwDices(times, sides) {
    List<int> results = [];
    for (int i = 0; i < int.parse(times); i++) {
      results.add(Random().nextInt(sides) + 1);
    }
    return results;
  }
}
