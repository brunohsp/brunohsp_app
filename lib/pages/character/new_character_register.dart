import 'package:brunohsp_app/controllers/calculate.dart';
import 'package:brunohsp_app/controllers/text_form_field_validations.dart';
import 'package:brunohsp_app/pages/character/new_resistance_register.dart';
import 'package:brunohsp_app/widgets/utils/classes_dropdown.dart';
import 'package:flutter/material.dart';

const List<String> list = <String>['Guerreiro', 'Bruxo', 'Paladino'];

class NewCharacterRegister extends StatefulWidget {
  const NewCharacterRegister({Key? key}) : super(key: key);

  @override
  State<NewCharacterRegister> createState() => _NewCharacterRegisterState();
}

class _NewCharacterRegisterState extends State<NewCharacterRegister> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final levelController = TextEditingController();
  final hpController = TextEditingController();
  final armorController = TextEditingController();
  final proeficiencyController = TextEditingController();

  String dropdownValue = list.first;

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
                  builder: (context) => NewResistanceRegister(),
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
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nome',
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: ClassesDropdown(columns: 4),
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
            controller: levelController,
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
            controller: hpController,
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
            controller: armorController,
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
            controller: proeficiencyController,
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
