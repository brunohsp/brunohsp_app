// ignore_for_file: must_be_immutable

import 'package:brunohsp_app/controllers/calculate.dart';
import 'package:brunohsp_app/models/resistance.dart';
import 'package:brunohsp_app/models/skill.dart';
import 'package:brunohsp_app/widgets/utils/skill_input.dart';
import 'package:flutter/material.dart';

class SkillUpdate extends StatefulWidget {
  final Resistance attributes;
  late Skill skills;
  final acrobaticsController = TextEditingController();
  final arcanaController = TextEditingController();
  final athleticsController = TextEditingController();
  final performanceController = TextEditingController();
  final deceptionController = TextEditingController();
  final stealthController = TextEditingController();
  final historyController = TextEditingController();
  final intimidationController = TextEditingController();
  final intuitionController = TextEditingController();
  final investigationController = TextEditingController();
  final handleWithAnimalsController = TextEditingController();
  final medicineController = TextEditingController();
  final natureController = TextEditingController();
  final perceptionController = TextEditingController();
  final persuationController = TextEditingController();
  final ilusionController = TextEditingController();
  final religionController = TextEditingController();
  final survivalController = TextEditingController();

  SkillUpdate({required this.attributes, Key? key}) : super(key: key) {
    skills = Skill(resistance: attributes, proficiencies: []);
    acrobaticsController.text = skills.acrobatics.toString();
    arcanaController.text = skills.arcana.toString();
    athleticsController.text = skills.athletics.toString();
    performanceController.text = skills.performance.toString();
    deceptionController.text = skills.deception.toString();
    stealthController.text = skills.stealth.toString();
    historyController.text = skills.history.toString();
    intimidationController.text = skills.intimidation.toString();
    intuitionController.text = skills.insight.toString();
    investigationController.text = skills.investigation.toString();
    handleWithAnimalsController.text = skills.animalHandling.toString();
    medicineController.text = skills.medicine.toString();
    natureController.text = skills.nature.toString();
    perceptionController.text = skills.perception.toString();
    persuationController.text = skills.persuation.toString();
    ilusionController.text = skills.sleightOfHand.toString();
    religionController.text = skills.religion.toString();
    survivalController.text = skills.survival.toString();
  }

  @override
  State<SkillUpdate> createState() => _SkillUpdateState();
}

class _SkillUpdateState extends State<SkillUpdate> {
  final _formKey = GlobalKey<FormState>();

  wrapButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: Calculate.widthWithColumns(2, MediaQuery.of(context).size.width),
        child: OutlinedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.popUntil(context, (route) => route.isFirst);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text('Ops, algo deu errado, verifique os Campos acima'),
                ),
              );
            }
          },
          child: const Text('Atualizar'),
        ),
      ),
    );
  }

  wrapInputs() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SkillInput(
          url: 'assets/icons/skillIcons/acrobatics.svg',
          skill: 'Acrobacia',
          value: widget.skills.acrobatics,
          controller: widget.acrobaticsController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/arcana.svg',
          skill: 'arcanao',
          value: widget.skills.arcana,
          controller: widget.arcanaController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/athletics.svg',
          skill: 'Atletismo',
          value: widget.skills.athletics,
          controller: widget.athleticsController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/performance.svg',
          skill: 'Atuação',
          value: widget.skills.performance,
          controller: widget.performanceController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/deception.svg',
          skill: 'Blefe',
          value: widget.skills.deception,
          controller: widget.deceptionController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/stealth.svg',
          skill: 'Furtividade',
          value: widget.skills.stealth,
          controller: widget.stealthController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/history.svg',
          skill: 'História',
          value: widget.skills.history,
          controller: widget.historyController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/intimidation.svg',
          skill: 'Indimidação',
          value: widget.skills.intimidation,
          controller: widget.intimidationController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/insight.svg',
          skill: 'Intuição',
          value: widget.skills.insight,
          controller: widget.intuitionController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/investigation.svg',
          skill: 'Investigação',
          value: widget.skills.investigation,
          controller: widget.investigationController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/animal_handling.svg',
          skill: 'Lidar com Animais',
          value: widget.skills.animalHandling,
          controller: widget.handleWithAnimalsController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/medicine.svg',
          skill: 'Medicina',
          value: widget.skills.medicine,
          controller: widget.medicineController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/nature.svg',
          skill: 'Natureza',
          value: widget.skills.nature,
          controller: widget.natureController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/perception.svg',
          skill: 'Percepção',
          value: widget.skills.perception,
          controller: widget.perceptionController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/persuation.svg',
          skill: 'Persuasão',
          value: widget.skills.persuation,
          controller: widget.persuationController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/sleight_of_hand.svg',
          skill: 'Ilusão',
          value: widget.skills.sleightOfHand,
          controller: widget.ilusionController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/religion.svg',
          skill: 'Religião',
          value: widget.skills.religion,
          controller: widget.religionController,
          proficiencyBonus: 0, //repository.newCharacter.proficiency,
          hasExpertise: false,//repository.newCharacter.dndClass.savingThrows.contains(Resistances.strength),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/survival.svg',
          skill: 'Sobrevivência',
          value: widget.skills.survival,
          controller: widget.survivalController,
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
