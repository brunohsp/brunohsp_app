import 'package:brunohsp_app/controllers/calculate.dart';
import 'package:brunohsp_app/controllers/text_form_field_validations.dart';
import 'package:brunohsp_app/pages/character/new_resistance_register.dart';
import 'package:brunohsp_app/repositories/character_form_repository.dart';
import 'package:brunohsp_app/widgets/utils/classes_dropdown.dart';
import 'package:brunohsp_app/widgets/utils/number_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewCharacterRegister extends StatefulWidget {
  const NewCharacterRegister({Key? key}) : super(key: key);

  @override
  State<NewCharacterRegister> createState() => _NewCharacterRegisterState();
}

class _NewCharacterRegisterState extends State<NewCharacterRegister> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final classController = TextEditingController();
  final levelController = TextEditingController();
  final hpController = TextEditingController();
  final armorController = TextEditingController();
  final proficiencyController = TextEditingController();

  late CharacterFormRepository repository = CharacterFormRepository();

  wrapButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: Calculate.widthWithColumns(2, MediaQuery.of(context).size.width),
        child: OutlinedButton(
          onPressed: () {
            if (_formKey.currentState!.validate() && classController.text != "") {
              repository.savingBySteps(1, {
                "name": nameController,
                "hp": hpController,
                "armor": armorController,
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                        create: (context) => repository,
                        child: const NewResistanceRegister())),
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
            keyboardType: TextInputType.name,
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nome',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child:
              ClassesDropdown(columns: 4, controller: classController), // aqui
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: NumberPicker.withAction(
              enabled: repository.isClassSelected,
              controller: levelController,
              labelText: 'Nível',
              min: 1,
              max: 20,
              pickerValue: repository.newCharacter.level,
              action: (int value) {
                proficiencyController.text = repository
                    .newCharacter.dndClass.profBonusesBylevel[value]!
                    .toString();

                repository.changeLevel(value);
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: NumberPicker.withAction(
            enabled: repository.isClassSelected,
            controller: hpController,
            labelText: 'HP',
            pickerValue: repository.newCharacter.hp,
            min: 1,
            max: 1000,
            action: (int value) {
              repository.changeHp(value);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: NumberPicker.withAction(
            enabled: repository.isClassSelected,
            controller: armorController,
            labelText: 'Armadura',
            pickerValue: repository.newCharacter.armor,
            action: (int value) {
              repository.changeArmor(value);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: NumberPicker.withValue(
            enabled: false,
            controller: proficiencyController,
            labelText: 'Proeficiência',
            pickerValue: repository.newCharacter.proficiency,
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
    repository = context.watch<CharacterFormRepository>();

    return Form(
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
    );
  }
}
