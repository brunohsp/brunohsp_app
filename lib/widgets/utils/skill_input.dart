// ignore_for_file: must_be_immutable

import 'package:brunohsp_app/controllers/text_form_field_validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SkillInput extends StatefulWidget {
  final String url;
  final String skill;
  final int value;
  final TextEditingController controller;

  SkillInput(
      {required this.url,
      required this.skill,
      required this.controller,
      this.value = 0,
      super.key});

  Color color = Colors.black;
  bool hasExpertise = false;

  @override
  State<SkillInput> createState() => _SkillInputState();
}

class _SkillInputState extends State<SkillInput> {
  expertiseController() {
    if(widget.controller.text.isEmpty){
      widget.controller.text = widget.value.toString();
    }

    if (!widget.hasExpertise) {
      widget.color = Colors.amber;
      widget.hasExpertise = true;
      int value = int.parse(widget.controller.text) + 2;
      widget.controller.text = value.toString();
    } else {
      widget.color = Colors.black;
      widget.hasExpertise = false;
      int value = int.parse(widget.controller.text) - 2;
      widget.controller.text = value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(
                () {
                  expertiseController();
                },
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(widget.color),
              shape: MaterialStateProperty.all(const CircleBorder()),
              padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            ),
            child: SvgPicture.asset(
              widget.url,
              height: 48,
              width: 48,
              color: Colors.white,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: widget.controller,
                validator: (String? input) {
                  if (TextFormFieldValidations.isEmpty(input)) {
                return 'Campo Vazio';
              }
              return TextFormFieldValidations.containsCharacters(input!)
                  ? "Campo deve conter apenas números"
                  : null;
                },
                onTap: () {
                  setState(() {
                    widget.hasExpertise = false;
                    widget.controller.text = widget.value.toString();
                    widget.color = Colors.black;
                    widget.hasExpertise = false;
                  });
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: widget.skill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
