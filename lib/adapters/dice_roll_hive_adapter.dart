import 'package:brunohsp_app/models/dice_roll.dart';
import 'package:hive/hive.dart';

class DiceRollHiveAdapter extends TypeAdapter<DiceRoll> {
  @override
  final typeId = 0;

  @override
  DiceRoll read(BinaryReader reader) {
    return DiceRoll(
      dice: reader.readString(),
      times: reader.readInt(),
      addition: reader.readInt(),
      results: reader.readIntList(),
    );
  }

  @override
  void write(BinaryWriter writer, DiceRoll obj) {
    writer.writeString(obj.dice);
    writer.writeInt(obj.times);
    writer.writeInt(obj.addition);
    writer.writeIntList(obj.results);
  }
}
