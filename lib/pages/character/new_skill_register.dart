// ignore_for_file: must_be_immutable

import 'package:brunohsp_app/controllers/calculate.dart';
import 'package:brunohsp_app/models/resistance.dart';
import 'package:brunohsp_app/models/skill.dart';
import 'package:brunohsp_app/widgets/utils/skill_input.dart';
import 'package:flutter/material.dart';

class NewSkillRegister extends StatefulWidget {
  final Resistance attributes;
  late Skill skills;
  final acrobacyController = TextEditingController();
  final arcanismController = TextEditingController();
  final athletismController = TextEditingController();
  final actuationController = TextEditingController();
  final bluffController = TextEditingController();
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

  NewSkillRegister({required this.attributes, Key? key}) : super(key: key) {
    skills = Skill(resistance: attributes);
    acrobacyController.text = skills.acrobacy.toString();
    arcanismController.text = skills.arcanism.toString();
    athletismController.text = skills.athletism.toString();
    actuationController.text = skills.actuation.toString();
    bluffController.text = skills.bluff.toString();
    stealthController.text = skills.stealth.toString();
    historyController.text = skills.history.toString();
    intimidationController.text = skills.intimidation.toString();
    intuitionController.text = skills.intuition.toString();
    investigationController.text = skills.investigation.toString();
    handleWithAnimalsController.text = skills.handleWithAnimals.toString();
    medicineController.text = skills.medicine.toString();
    natureController.text = skills.nature.toString();
    perceptionController.text = skills.perception.toString();
    persuationController.text = skills.persuation.toString();
    ilusionController.text = skills.ilusion.toString();
    religionController.text = skills.religion.toString();
    survivalController.text = skills.survival.toString();
  }

  @override
  State<NewSkillRegister> createState() => _NewSkillRegisterState();
}

class _NewSkillRegisterState extends State<NewSkillRegister> {
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
                  content: Text('Ops, algo deu errado, verifique os Campos acima'),
                ),
              );
            }
          },
          child: const Text('Salvar'),
        ),
      ),
    );
  }

  wrapInputs() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SkillInput(
          url: 'assets/icons/skillIcons/acrobacy.svg',
          skill: 'Acrobacia',
          value: widget.skills.acrobacy,
          controller: widget.acrobacyController,
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/arcanism.svg',
          skill: 'Arcanismo',
          value: widget.skills.arcanism,
          controller: widget.arcanismController,
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/athletism.svg',
          skill: 'Atletismo',
          value: widget.skills.athletism,
          controller: widget.athletismController,
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/actuation.svg',
          skill: 'Atuação',
          value: widget.skills.actuation,
          controller: widget.actuationController,
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/bluff.svg',
          skill: 'Blefe',
          value: widget.skills.bluff,
          controller: widget.bluffController,
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/stealth.svg',
          skill: 'Furtividade',
          value: widget.skills.stealth,
          controller: widget.stealthController,
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/history.svg',
          skill: 'História',
          value: widget.skills.history,
          controller: widget.historyController,
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/intimidation.svg',
          skill: 'Indimidação',
          value: widget.skills.intimidation,
          controller: widget.intimidationController,
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/intuition.svg',
          skill: 'Intuição',
          value: widget.skills.intuition,
          controller: widget.intuitionController,
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/investigation.svg',
          skill: 'Investigação',
          value: widget.skills.investigation,
          controller: widget.investigationController,
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/handle_with_animals.svg',
          skill: 'Lidar com Animais',
          value: widget.skills.handleWithAnimals,
          controller: widget.handleWithAnimalsController,
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/medicine.svg',
          skill: 'Medicina',
          value: widget.skills.medicine,
          controller: widget.medicineController,
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/nature.svg',
          skill: 'Natureza',
          value: widget.skills.nature,
          controller: widget.natureController,
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/perception.svg',
          skill: 'Percepção',
          value: widget.skills.perception,
          controller: widget.perceptionController,
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/persuation.svg',
          skill: 'Persuasão',
          value: widget.skills.persuation,
          controller: widget.persuationController,
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/ilusion.svg',
          skill: 'Ilusão',
          value: widget.skills.ilusion,
          controller: widget.ilusionController,
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/religion.svg',
          skill: 'Religião',
          value: widget.skills.religion,
          controller: widget.religionController,
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/survival.svg',
          skill: 'Sobrevivência',
          value: widget.skills.survival,
          controller: widget.survivalController,
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
            'Cadastro de Personagem',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: wrapBody(),
      ),
    );
  }
}
