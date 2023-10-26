// ignore_for_file: must_be_immutable

import 'package:brunohsp_app/controllers/calculate.dart';
import 'package:brunohsp_app/models/skill.dart';
import 'package:brunohsp_app/repositories/character_form_repository.dart';
import 'package:brunohsp_app/widgets/utils/skill_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SkillForm extends StatefulWidget {
  const SkillForm({Key? key}) : super(key: key);

  @override
  State<SkillForm> createState() => _SkillFormState();
}

class _SkillFormState extends State<SkillForm> {
  final _formKey = GlobalKey<FormState>();

  final acrobaticsController = TextEditingController();
  final arcanaController = TextEditingController();
  final athleticsController = TextEditingController();
  final performanceController = TextEditingController();
  final deceptionController = TextEditingController();
  final stealthController = TextEditingController();
  final historyController = TextEditingController();
  final intimidationController = TextEditingController();
  final insightController = TextEditingController();
  final investigationController = TextEditingController();
  final animalHandlingController = TextEditingController();
  final medicineController = TextEditingController();
  final natureController = TextEditingController();
  final perceptionController = TextEditingController();
  final persuationController = TextEditingController();
  final sleightOfHandController = TextEditingController();
  final religionController = TextEditingController();
  final survivalController = TextEditingController();

  late CharacterFormRepository repository;

  _goBack() => Navigator.popUntil(context, (route) => route.isFirst);

  wrapButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: Calculate.widthWithColumns(2, MediaQuery.of(context).size.width),
        child: OutlinedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await repository.savingBySteps(3, {
                "acrobatics": acrobaticsController,
                "arcana": arcanaController,
                "athletics": athleticsController,
                "performance": performanceController,
                "deception": deceptionController,
                "stealth": stealthController,
                "history": historyController,
                "intimidation": intimidationController,
                "insight": insightController,
                "investigation": investigationController,
                "animalHandling": animalHandlingController,
                "medicine": medicineController,
                "nature": natureController,
                "perception": perceptionController,
                "persuation": persuationController,
                "sleightOfHand": sleightOfHandController,
                "religion": religionController,
                "survival": survivalController,
              });
              _goBack();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text('Ops, algo deu errado, verifique os Campos acima'),
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
    List<Skills> skills = repository.newCharacter.dndClass.possibleSkills;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SkillInput(
          url: 'assets/icons/skillIcons/acrobatics.svg',
          skill: 'Acrobacia',
          value: repository.newCharacter.skills.acrobatics,
          controller: acrobaticsController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: skills.contains(Skills.acrobatics),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/arcana.svg',
          skill: 'Arcanismo',
          value: repository.newCharacter.skills.arcana,
          controller: arcanaController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: skills.contains(Skills.arcana),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/athletics.svg',
          skill: 'Atletismo',
          value: repository.newCharacter.skills.athletics,
          controller: athleticsController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: skills.contains(Skills.athletics),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/performance.svg',
          skill: 'Atuação',
          value: repository.newCharacter.skills.performance,
          controller: performanceController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: skills.contains(Skills.performance),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/deception.svg',
          skill: 'Blefe',
          value: repository.newCharacter.skills.deception,
          controller: deceptionController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: skills.contains(Skills.deception),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/stealth.svg',
          skill: 'Furtividade',
          value: repository.newCharacter.skills.stealth,
          controller: stealthController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: skills.contains(Skills.stealth),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/history.svg',
          skill: 'História',
          value: repository.newCharacter.skills.history,
          controller: historyController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: skills.contains(Skills.history),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/intimidation.svg',
          skill: 'Indimidação',
          value: repository.newCharacter.skills.intimidation,
          controller: intimidationController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: skills.contains(Skills.intimidation),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/insight.svg',
          skill: 'Intuição',
          value: repository.newCharacter.skills.insight,
          controller: insightController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: skills.contains(Skills.insight),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/investigation.svg',
          skill: 'Investigação',
          value: repository.newCharacter.skills.investigation,
          controller: investigationController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: skills.contains(Skills.investigation),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/animal_handling.svg',
          skill: 'Lidar com Animais',
          value: repository.newCharacter.skills.animalHandling,
          controller: animalHandlingController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: skills.contains(Skills.animalHandling),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/medicine.svg',
          skill: 'Medicina',
          value: repository.newCharacter.skills.medicine,
          controller: medicineController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: skills.contains(Skills.medicine),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/nature.svg',
          skill: 'Natureza',
          value: repository.newCharacter.skills.nature,
          controller: natureController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: skills.contains(Skills.nature),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/perception.svg',
          skill: 'Percepção',
          value: repository.newCharacter.skills.perception,
          controller: perceptionController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: skills.contains(Skills.perception),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/persuation.svg',
          skill: 'Persuasão',
          value: repository.newCharacter.skills.persuation,
          controller: persuationController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: skills.contains(Skills.persuation),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/sleight_of_hand.svg',
          skill: 'Ilusão',
          value: repository.newCharacter.skills.sleightOfHand,
          controller: sleightOfHandController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: skills.contains(Skills.sleightOfHand),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/religion.svg',
          skill: 'Religião',
          value: repository.newCharacter.skills.religion,
          controller: religionController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: skills.contains(Skills.religion),
        ),
        SkillInput(
          url: 'assets/icons/skillIcons/survival.svg',
          skill: 'Sobrevivência',
          value: repository.newCharacter.skills.survival,
          controller: survivalController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: skills.contains(Skills.survival),
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
    repository = Provider.of<CharacterFormRepository>(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            centerTitle: true,
            title: const Text(
              'Cadastro de Personagem',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          body: wrapBody(),
        ),
      ),
    );
  }
}
