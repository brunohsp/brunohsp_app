// ignore_for_file: must_be_immutable

import 'package:brunohsp_app/controllers/calculate.dart';
import 'package:brunohsp_app/models/resistance.dart';
import 'package:brunohsp_app/pages/character/skill_form.dart';
import 'package:brunohsp_app/repositories/character_form_repository.dart';
import 'package:brunohsp_app/widgets/utils/skill_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResistanceForm extends StatefulWidget {
  const ResistanceForm({Key? key}) : super(key: key);

  @override
  State<ResistanceForm> createState() => _ResistanceFormState();
}

class _ResistanceFormState extends State<ResistanceForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController strengthController = TextEditingController();
  final TextEditingController intelligencyController = TextEditingController();
  final TextEditingController dexterityController = TextEditingController();
  final TextEditingController wisdomController = TextEditingController();
  final TextEditingController constitutionController = TextEditingController();
  final TextEditingController charismController = TextEditingController();

  late CharacterFormRepository repository;

  wrapButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: Calculate.widthWithColumns(2, MediaQuery.of(context).size.width),
        child: OutlinedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              repository.savingBySteps(2, {
                "strength": strengthController,
                "inteligency": intelligencyController,
                "dexterity": dexterityController,
                "wisdom": wisdomController,
                "constitution": constitutionController,
                "charism": charismController,
              });

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => repository,
                    lazy: false,
                    child: const SkillForm(),
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
    List<Resistances> savingThrows =
        repository.newCharacter.dndClass.savingThrows;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SkillInput.withoutValue(
          url: 'assets/icons/resistanceIcons/strength.svg',
          skill: 'Força',
          controller: strengthController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: savingThrows.contains(Resistances.strength),
        ),
        SkillInput.withoutValue(
          url: 'assets/icons/resistanceIcons/intelligency.svg',
          skill: 'Inteligência',
          controller: intelligencyController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: savingThrows.contains(Resistances.intelligency),
        ),
        SkillInput.withoutValue(
          url: 'assets/icons/resistanceIcons/dexterity.svg',
          skill: 'Destreza',
          controller: dexterityController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: savingThrows.contains(Resistances.dexterity),
        ),
        SkillInput.withoutValue(
          url: 'assets/icons/resistanceIcons/wisdom.svg',
          skill: 'Sabedoria',
          controller: wisdomController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: savingThrows.contains(Resistances.wisdom),
        ),
        SkillInput.withoutValue(
          url: 'assets/icons/resistanceIcons/constitution.svg',
          skill: 'Constituição',
          controller: constitutionController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: savingThrows.contains(Resistances.constitution),
        ),
        SkillInput.withoutValue(
          url: 'assets/icons/resistanceIcons/charism.svg',
          skill: 'Carisma',
          controller: charismController,
          proficiencyBonus: repository.newCharacter.proficiency,
          hasExpertise: savingThrows.contains(Resistances.charism),
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
