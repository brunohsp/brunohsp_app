// ignore_for_file: must_be_immutable

import 'package:brunohsp_app/controllers/calculate.dart';
import 'package:brunohsp_app/models/resistance.dart';
import 'package:brunohsp_app/pages/character/new_skill_register.dart';
import 'package:brunohsp_app/widgets/utils/skill_input.dart';
import 'package:flutter/material.dart';

class NewResistanceRegister extends StatefulWidget {
  late Resistance attributes;
  final TextEditingController strengthController =
      TextEditingController(text: '0');
  final TextEditingController inteligencyController =
      TextEditingController(text: '0');
  final TextEditingController dexterityController =
      TextEditingController(text: '0');
  final TextEditingController wisdomController =
      TextEditingController(text: '0');
  final TextEditingController constitutionController =
      TextEditingController(text: '0');
  final TextEditingController charismController =
      TextEditingController(text: '0');
  NewResistanceRegister({Key? key}) : super(key: key);

  @override
  State<NewResistanceRegister> createState() => _NewResistanceRegisterState();
}

class _NewResistanceRegisterState extends State<NewResistanceRegister> {
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
                int.parse(widget.strengthController.text),
                int.parse(widget.inteligencyController.text),
                int.parse(widget.dexterityController.text),
                int.parse(widget.wisdomController.text),
                int.parse(widget.constitutionController.text),
                int.parse(widget.charismController.text),
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewSkillRegister(
                    attributes: widget.attributes,
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ops, algo deu errado, verifique os Campos acima'),
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
        ),
        SkillInput(
          url: 'assets/icons/resistanceIcons/intelligency.svg',
          skill: 'Inteligência',
          value: 0,
          controller: widget.inteligencyController,
        ),
        SkillInput(
          url: 'assets/icons/resistanceIcons/dexterity.svg',
          skill: 'Destreza',
          value: 0,
          controller: widget.dexterityController,
        ),
        SkillInput(
          url: 'assets/icons/resistanceIcons/wisdom.svg',
          skill: 'Sabedoria',
          value: 0,
          controller: widget.wisdomController,
        ),
        SkillInput(
          url: 'assets/icons/resistanceIcons/constitution.svg',
          skill: 'Constituição',
          value: 0,
          controller: widget.constitutionController,
        ),
        SkillInput(
          url: 'assets/icons/resistanceIcons/charism.svg',
          skill: 'Carisma',
          value: 0,
          controller: widget.charismController,
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
