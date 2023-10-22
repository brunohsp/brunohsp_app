import 'package:brunohsp_app/controllers/calculate.dart';
import 'package:brunohsp_app/repositories/character_form_repository.dart';
import 'package:flutter/material.dart';
import 'package:brunohsp_app/models/dnd_class.dart';
import 'package:brunohsp_app/services/class_service.dart';
import 'package:provider/provider.dart';

// TODO: ADD VALIDATION
class ClassesDropdown extends StatefulWidget {
  final int columns;
  final TextEditingController controller;
  const ClassesDropdown(
      {required this.columns, required this.controller, Key? key})
      : super(key: key);

  @override
  State<ClassesDropdown> createState() => _ClassesDropdownState();
}

class _ClassesDropdownState extends State<ClassesDropdown> {
  final DndClassService service = DndClassService();
  late CharacterFormRepository newCharacter = CharacterFormRepository();
  late List<DndClass> list = [];
  List<DropdownMenuEntry<String>> dropdownList = [
    const DropdownMenuEntry(value: "placeholder", label: "Classe")
  ];
  String dropdownValue = "placeholder";

  List<DropdownMenuEntry<String>> convertList(List<DndClass> list) {
    return list.map<DropdownMenuEntry<String>>((DndClass dndClass) {
      return DropdownMenuEntry<String>(
          value: dndClass.index, label: dndClass.name);
    }).toList();
  }

  void refresh() async {
    list = await service.getAll();
    setState(() {
      dropdownList = convertList(list);
    });
  }

  void selectClass(value) async {
    dropdownValue = value;
    DndClass selectedIndex = DndClass();

    for (DndClass dndClass in list) {
      if (dndClass.index == value) {
        selectedIndex = await service.getByIndex(dndClass.index);
        break;
      }
    }

    widget.controller.text = selectedIndex.name;
    newCharacter.saveClass(selectedIndex);
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    newCharacter = context.watch<CharacterFormRepository>();

    // ignore: unused_local_variable
    return Column(
      children: [
        DropdownMenu<String>(
          width: Calculate.widthWithColumns(
              widget.columns, MediaQuery.of(context).size.width),
          onSelected: (String? value) {
            setState(() {
              selectClass(value);
            });
          },
          controller: widget.controller,
          dropdownMenuEntries: dropdownList,
          label: const Text("Classe"),
        ),
      ],
    );
  }
}
