// ignore_for_file: must_be_immutable

import 'package:brunohsp_app/controllers/calculate.dart';
import 'package:brunohsp_app/models/resistance.dart';
import 'package:brunohsp_app/pages/character/skill_update.dart';
import 'package:brunohsp_app/widgets/utils/skill_input.dart';
import 'package:flutter/material.dart';

class ResistanceUpdate extends StatefulWidget {
  late Resistance attributes;
  final strengthController = TextEditingController();
  final inteligencyController = TextEditingController();
  final dexterityController = TextEditingController();
  final wisdomController = TextEditingController();
  final constitutionController = TextEditingController();
  final charismController = TextEditingController();
  ResistanceUpdate({required this.attributes, Key? key}) : super(key: key) {
    strengthController.text = attributes.strength.toString();
    inteligencyController.text = attributes.inteligency.toString();
    dexterityController.text = attributes.dexterity.toString();
    wisdomController.text = attributes.wisdom.toString();
    constitutionController.text = attributes.constitution.toString();
    charismController.text = attributes.charism.toString();
  }

  @override
  State<ResistanceUpdate> createState() => _ResistanceUpdateState();
}

class _ResistanceUpdateState extends State<ResistanceUpdate> {
  final _formKey = GlobalKey<FormState>();

  wrapButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: Calculate.widthWithColumns(2, MediaQuery.of(context).size.width),
        child: OutlinedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.attributes = Resistance(
                strength: int.parse(widget.strengthController.text),
                inteligency: int.parse(widget.inteligencyController.text),
                dexterity: int.parse(widget.dexterityController.text),
                wisdom: int.parse(widget.wisdomController.text),
                constitution: int.parse(widget.constitutionController.text),
                charism: int.parse(widget.charismController.text),
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SkillUpdate(
                    attributes: widget.attributes,
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text('Ops, algo deu errado, verifique os Campos acima'),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SkillInput(
          url: 'assets/icons/resistanceIcons/strength.svg',
          skill: 'Força',
          value: 0,
          controller: widget.strengthController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
        ),
        SkillInput(
          url: 'assets/icons/resistanceIcons/intelligency.svg',
          skill: 'Inteligência',
          value: 0,
          controller: widget.inteligencyController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
        ),
        SkillInput(
          url: 'assets/icons/resistanceIcons/dexterity.svg',
          skill: 'Destreza',
          value: 0,
          controller: widget.dexterityController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
        ),
        SkillInput(
          url: 'assets/icons/resistanceIcons/wisdom.svg',
          skill: 'Sabedoria',
          value: 0,
          controller: widget.wisdomController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
        ),
        SkillInput(
          url: 'assets/icons/resistanceIcons/constitution.svg',
          skill: 'Constituição',
          value: 0,
          controller: widget.constitutionController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
        ),
        SkillInput(
          url: 'assets/icons/resistanceIcons/charism.svg',
          skill: 'Carisma',
          value: 0,
          controller: widget.charismController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
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
