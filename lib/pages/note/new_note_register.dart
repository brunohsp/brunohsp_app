import 'package:brunohsp_app/controllers/calculate.dart';
import 'package:brunohsp_app/controllers/text_form_field_validations.dart';
import 'package:flutter/material.dart';

const List<String> list = <String>['Guerreiro', 'Bruxo', 'Paladino'];

class NewNoteRegister extends StatefulWidget {
  // TODO: KILL THIS SHIT
  const NewNoteRegister({Key? key}) : super(key: key);

  @override
  State<NewNoteRegister> createState() => _NewNoteRegisterState();
}

class _NewNoteRegisterState extends State<NewNoteRegister> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final noteController = TextEditingController();

  String dropdownValue = list.first;

  wrapButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: Calculate.widthWithColumns(2, MediaQuery.of(context).size.width),
        child: OutlinedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Há um ou mais campos vazios!'),
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextFormField(
            validator: (String? input) {
              if (TextFormFieldValidations.isEmpty(input)) {
                return 'Campo Vazio';
              }
              return null;
            },
            controller: titleController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Título',
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
              return null;
            },
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.top,
            controller: noteController,
            maxLines: 15,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nota',
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
            'Nova Nota',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: wrapBody(),
      ),
    );
  }
}
