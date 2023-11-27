import 'dart:collection';

import 'package:brunohsp_app/adapters/dice_roll_hive_adapter.dart';
import 'package:brunohsp_app/models/dice_roll.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DicesRepository extends ChangeNotifier{
  final List<DiceRoll> _list = [];
  late LazyBox box;

  UnmodifiableListView<DiceRoll> get list => UnmodifiableListView(_list);

  DicesRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _openBox();
    await _readRolls();
  }

  _openBox() async {
    Hive.registerAdapter(DiceRollHiveAdapter());
    box = await Hive.openLazyBox('dice_rolls');
  }

  _readRolls() {
    box.keys.forEach((dr) async {
      DiceRoll rolls = await box.get(dr);
      _list.add(rolls);
    });
    notifyListeners();
  }

  refresh() async {
    _readRolls();
  }

  saveRoll(DiceRoll dr) {
    _list.add(dr);
    box.put('${dr.dice} + ${dr.addition}= ${dr.results}', dr);

    notifyListeners();
  }

  remove(DiceRoll dr) async {
    _list.remove(dr);
    await box.delete('${dr.dice} + ${dr.addition}= ${dr.results}');

    notifyListeners();
  }
}
