import 'package:brunohsp_app/controllers/calculate.dart';
import 'package:flutter/material.dart';

class ClassesDropdown extends StatefulWidget {
  final int columns;
  const ClassesDropdown({required this.columns, Key? key}) : super(key: key);

  @override
  State<ClassesDropdown> createState() => _ClassesDropdownState();
}

class _ClassesDropdownState extends State<ClassesDropdown> {
  @override
  Widget build(BuildContext context) {
    const List<String> list = <String>['Guerreiro', 'Bruxo', 'Paladino'];
    // ignore: unused_local_variable
    String dropdownValue = list.first;

    return DropdownMenu<String>(
      width: Calculate.widthWithColumns(widget.columns, MediaQuery.of(context).size.width),
      initialSelection: list.first,
      onSelected: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
