// ignore_for_file: must_be_immutable

import 'package:brunohsp_app/controllers/calculate.dart';
import 'package:brunohsp_app/controllers/text_form_field_validations.dart';
import 'package:brunohsp_app/models/character.dart';
import 'package:brunohsp_app/pages/character/resistance_update.dart';
import 'package:brunohsp_app/widgets/utils/classes_dropdown.dart';
import 'package:flutter/material.dart';

const List<String> list = <String>['Guerreiro', 'Bruxo', 'Paladino'];

class CharacterUpdate extends StatefulWidget {
  final Character character;
  final nameController = TextEditingController();
  final classController = TextEditingController();
  final levelController = TextEditingController();
  final hpController = TextEditingController();
  final armorController = TextEditingController();
  final proeficiencyController = TextEditingController();
  late String dropdownValue;

  CharacterUpdate({required this.character, Key? key}) : super(key: key) {
    nameController.text = character.name;
    levelController.text = character.level.toString();
    hpController.text = character.hp.toString();
    armorController.text = character.armor.toString();
    proeficiencyController.text = character.proficiency.toString();
    dropdownValue = character.dndClass.name;
  }

  @override
  State<CharacterUpdate> createState() => _CharacterUpdateState();
}

class _CharacterUpdateState extends State<CharacterUpdate> {
  final _formKey = GlobalKey<FormState>();

  wrapButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: Calculate.widthWithColumns(2, MediaQuery.of(context).size.width),
        child: OutlinedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResistanceUpdate(
                    attributes: widget.character.resistances,
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Há um ou mais campos vazios!'),
                ),
              );
            }
          },
          child: const Text('Prosseguir'),
        ),
      ),
    );
  }

  wrapInputs() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 64,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.camera_alt_rounded),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextFormField(
            validator: (String? input) {
              if (TextFormFieldValidations.isEmpty(input)) {
                return 'Campo Vazio';
              }
              return null;
            },
            controller: widget.nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nome',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: ClassesDropdown(columns: 4, controller: widget.classController,),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextFormField(
            validator: (String? input) {
              if (TextFormFieldValidations.isEmpty(input)) {
                return 'Campo Vazio';
              }
              return TextFormFieldValidations.containsCharacters(input!)
                  ? "Campo deve conter apenas números"
                  : null;
            },
            controller: widget.levelController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nível',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextFormField(
            validator: (String? input) {
              if (TextFormFieldValidations.isEmpty(input)) {
                return 'Campo Vazio';
              }
              return TextFormFieldValidations.containsCharacters(input!)
                  ? "Campo deve conter apenas números"
                  : null;
            },
            controller: widget.hpController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'HP',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextFormField(
            validator: (String? input) {
              if (TextFormFieldValidations.isEmpty(input)) {
                return 'Campo Vazio';
              }
              return TextFormFieldValidations.containsCharacters(input!)
                  ? "Campo deve conter apenas números"
                  : null;
            },
            controller: widget.armorController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Armadura',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextFormField(
            validator: (String? input) {
              if (TextFormFieldValidations.isEmpty(input)) {
                return 'Campo Vazio';
              }
              return TextFormFieldValidations.containsCharacters(input!)
                  ? "Campo deve conter apenas números"
                  : null;
            },
            controller: widget.proeficiencyController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Proeficiência',
            ),
          ),
        ),
      ],
    );
  }

  wrapBody() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              wrapInputs(),
              wrapButtons(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: const Text(
            'Atualização de Personagem',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: wrapBody(),
      ),
    );
  }
}
