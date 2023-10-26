import 'dart:math';

class DiceAvatarController {
  static List<int> throwDices(int times, int sides, int increment) {
    List<int> results = [];
    for (int i = 0; i < times; i++) {
      results.add(Random().nextInt(sides) + 1 + increment);
    }
    return results;
  }
}
