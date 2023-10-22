// ignore_for_file: must_be_immutable

import 'package:brunohsp_app/widgets/utils/number_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SkillInput extends StatefulWidget {
  final String url;
  final String skill;
  late int value;
  final int proficiencyBonus;
  final bool hasExpertise;
  final TextEditingController controller;

  SkillInput(
      {required this.url,
      required this.skill,
      required this.controller,
      required this.proficiencyBonus,
      required this.hasExpertise,
      this.value = 0,
      super.key});

  SkillInput.withoutValue(
      {required this.url,
      required this.skill,
      required this.controller,
      required this.proficiencyBonus,
      required this.hasExpertise,
      super.key}){
        value = hasExpertise ? proficiencyBonus : 0;
      }

  @override
  State<SkillInput> createState() => _SkillInputState();
}

class _SkillInputState extends State<SkillInput> {
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
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  widget.hasExpertise ? Colors.amber : Colors.black),
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
              child: NumberPicker.withValue(
                labelText: widget.skill,
                controller: widget.controller,
                min: widget.hasExpertise ? widget.proficiencyBonus : widget.value,
                pickerValue: widget.value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
