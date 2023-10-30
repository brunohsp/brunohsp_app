import 'dart:io';

import 'package:brunohsp_app/controllers/calculate.dart';
import 'package:brunohsp_app/controllers/text_form_field_validations.dart';
import 'package:brunohsp_app/models/character.dart';
import 'package:brunohsp_app/pages/character/resistance_form.dart';
import 'package:brunohsp_app/repositories/character_form_repository.dart';
import 'package:brunohsp_app/widgets/utils/classes_dropdown.dart';
import 'package:brunohsp_app/widgets/utils/number_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CharacterForm extends StatefulWidget {
  final bool isCreate;
  final Character? character;
  const CharacterForm({this.isCreate = true, this.character, Key? key})
      : super(key: key);

  @override
  State<CharacterForm> createState() => CharacterFormState();
}

class CharacterFormState extends State<CharacterForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final classController = TextEditingController();
  final levelController = TextEditingController();
  final hpController = TextEditingController();
  final armorController = TextEditingController();
  final proficiencyController = TextEditingController();

  XFile? image;

  late CharacterFormRepository repository;
  bool wasInitialized = false;

  wrapButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: Calculate.widthWithColumns(2, MediaQuery.of(context).size.width),
        child: OutlinedButton(
          onPressed: () {
            if (_formKey.currentState!.validate() &&
                classController.text != "") {
              if (widget.character != null) {
                repository.newCharacter.id = widget.character!.id;
              }
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
                        child: const ResistanceForm())),
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

  selectImage() async {
    final ImagePicker picker = ImagePicker();

    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        repository.newCharacter.imageInfos["id"] =
            'img-${DateTime.now().toString()}.jpeg';
        repository.newCharacter.imageInfos["image"] = file;
        setState(() => image = file);
      }
    } catch (e) {
      SnackBar(
        content: Text(
          'Erro ao selecionar imagem: $e',
          textAlign: TextAlign.center,
        ),
        duration: const Duration(milliseconds: 3000),
        padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 8.0 // Inner padding for SnackBar content.
            ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      );
    }
  }

  imageAvatar() {
    return widget.isCreate
        ? [
            CircleAvatar(
              radius: 64,
              backgroundImage: image != null
                  ? Image.file(
                      File(image!.path),
                      fit: BoxFit.cover,
                    ).image
                  : null,
            ),
            IconButton(
              onPressed: selectImage,
              icon: const Icon(Icons.camera_alt_rounded),
            ),
          ]
        : [Container()];
  }

  wrapInputs() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...imageAvatar(),
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

  _initializateForm() {
    wasInitialized = true;
    repository.saveClass(widget.character!.dndClass);

    nameController.text = widget.character!.name;
    classController.text = widget.character!.dndClass.name;
    levelController.text = widget.character!.level.toString();
    hpController.text = widget.character!.hp.toString();
    armorController.text = widget.character!.armor.toString();
    proficiencyController.text = widget.character!.proficiency.toString();
  }

  @override
  Widget build(BuildContext context) {
    repository = context.watch<CharacterFormRepository>();
    if (widget.character != null && !wasInitialized) _initializateForm();

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
