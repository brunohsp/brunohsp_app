import 'package:brunohsp_app/controllers/calculate.dart';
import 'package:brunohsp_app/controllers/text_form_field_validations.dart';
import 'package:flutter/material.dart';

const List<String> list = <String>['Guerreiro', 'Bruxo', 'Paladino'];

class NoteUpdate extends StatefulWidget {
  final String title;
  final DateTime date;
  final String note;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  NoteUpdate({
    required this.title,
    required this.date,
    required this.note,
    Key? key,
  }) : super(key: key) {
    titleController.text = title;
    noteController.text = note;
  }

  @override
  State<NoteUpdate> createState() => _NoteUpdateState();
}

class _NoteUpdateState extends State<NoteUpdate> {
  final _formKey = GlobalKey<FormState>();

  String dropdownValue = list.first;

  confirmationModal() {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Você tem certeza que deseja remover está nota?',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )),
                Row(
                  children: [
                    SizedBox(
                      width: Calculate.widthWithColumns(
                          2, MediaQuery.of(context).size.width),
                      child: FilledButton(
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        child: const Text('Sim'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: Calculate.widthWithColumns(
                          2, MediaQuery.of(context).size.width),
                      child: OutlinedButton(
                        child: const Text('Não'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  wrapButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width:
              Calculate.widthWithColumns(2, MediaQuery.of(context).size.width),
          child: FilledButton(
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
            child: const Text('Atualizar'),
          ),
        ),
        SizedBox(
          width:
              Calculate.widthWithColumns(2, MediaQuery.of(context).size.width),
          child: OutlinedButton(
            onPressed: () {
              confirmationModal();
            },
            child: const Text('Remover'),
          ),
        ),
      ],
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
            controller: widget.titleController,
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
            controller: widget.noteController,
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
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: wrapBody(),
      ),
    );
  }
}
