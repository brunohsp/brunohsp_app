// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class NumberPicker extends StatefulWidget {
  final TextEditingController controller;
  final int min;
  final int max;
  NumberPicker({
    required this.controller,
    this.min = 0,
    this.max = 100,
    super.key,
  }){
    controller.text = '1';
  }
  int pickerValue = 1;

  @override
  State<NumberPicker> createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {

  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              if (widget.pickerValue > widget.min) {
                widget.pickerValue -= 1;
                widget.controller.text = widget.pickerValue.toString();
              }
            });
          },
          icon: const Icon(
            Icons.chevron_left_rounded,
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: TextFormField(
              textAlign: TextAlign.center,
              readOnly: true,
              controller: widget.controller,
              keyboardType: TextInputType.number,
              validator: (String? value) {
                if (valueValidator(value)) {
                  return 'Campo Vazio';
                }
                return null;
              },
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              if (widget.pickerValue < widget.max) {
                widget.pickerValue += 1;
                widget.controller.text = widget.pickerValue.toString();

              }
            });
          },
          icon: const Icon(
            Icons.chevron_right_rounded,
          ),
        ),
      ],
    );
  }
}
