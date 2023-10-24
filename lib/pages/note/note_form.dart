import 'package:brunohsp_app/controllers/calculate.dart';
import 'package:brunohsp_app/controllers/text_form_field_validations.dart';
import 'package:brunohsp_app/models/note.dart';
import 'package:brunohsp_app/repositories/notes_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteForm extends StatefulWidget {
  final bool isCreate;
  final Note? selectedNote;
  const NoteForm({required this.isCreate, this.selectedNote, Key? key})
      : super(key: key);

  @override
  State<NoteForm> createState() => _NoteFormState();
}

//TODO: add snackbar with errors and response

class _NoteFormState extends State<NoteForm> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final noteController = TextEditingController();
  late NotesRepository repository;

  late String actionButton;
  late String pageTitle;

  @override
  void initState() {
    super.initState();
    setFormType();

    if(widget.selectedNote != null){
      titleController.text = widget.selectedNote!.sectionName;
        noteController.text = widget.selectedNote!.content;
    }
  }

  setFormType() {
    setState(() {
      if (widget.isCreate) {
        actionButton = 'Salvar';
        pageTitle = 'Nova Nota';
      } else {
        actionButton = 'Atualizar';
        pageTitle = 'Atualizar Nota';
      }
    });
  }

  onAction() async {
    Note note = Note(
      sectionName: titleController.text,
      content: noteController.text,
      date: DateTime.now(),
    );

    if (!widget.isCreate && widget.selectedNote != null) {
      await repository.remove(widget.selectedNote as Note);
    }

    await repository.saveOneNote(note);
  }

  onRemove() async {
    return await repository.remove(widget.selectedNote as Note);
  }

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
                          onRemove();
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
      mainAxisAlignment: widget.isCreate
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width:
              Calculate.widthWithColumns(2, MediaQuery.of(context).size.width),
          child: FilledButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                onAction();
                Navigator.popUntil(context, (route) => route.isFirst);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Há um ou mais campos vazios!'),
                  ),
                );
              }
            },
            child: Text(actionButton),
          ),
        ),
        if (!widget.isCreate)
          SizedBox(
            width: Calculate.widthWithColumns(
                2, MediaQuery.of(context).size.width),
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
            maxLines: 20,
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            wrapInputs(),
            wrapButtons(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    repository = context.read<NotesRepository>();
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 10,
          centerTitle: true,
          title: Text(
            pageTitle,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: wrapBody(),
      ),
    );
  }
}
