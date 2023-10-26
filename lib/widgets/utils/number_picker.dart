// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class NumberPicker extends StatefulWidget {
  final TextEditingController controller;
  final int min;
  final int max;
  final bool enabled;
  final String labelText;
  int pickerValue = 0;
  Function action = (int value) {};
  NumberPicker({
    required this.controller,
    required this.labelText,
    this.min = 0,
    this.max = 100,
    this.enabled = true,
    super.key,
  }) {
    pickerValue = min;
    controller.text = '$min';
  }

  NumberPicker.withAction({
    required this.controller,
    required this.labelText,
    required this.action,
    required this.pickerValue,
    this.min = 0,
    this.max = 100,
    this.enabled = true,
    super.key,
  }) {
    if(controller.text.isEmpty) {
      controller.text = '$pickerValue';
    } else {
      pickerValue = int.parse(controller.text);
    }
  }

  NumberPicker.withValue({
    required this.controller,
    required this.labelText,
    required this.pickerValue,
    this.min = 0,
    this.max = 100,
    this.enabled = true,
    super.key,
  }) {
    if(controller.text.isEmpty) {
      controller.text = '$pickerValue';
    } else {
      pickerValue = int.parse(controller.text);
    }
  }

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
            if (widget.enabled && widget.pickerValue > widget.min) {
              setState(() {
                widget.pickerValue -= 1;
                widget.controller.text = widget.pickerValue.toString();
              });
                widget.action(widget.pickerValue);
            }
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
              enabled: widget.enabled,
              readOnly: true,
              controller: widget.controller,
              validator: (String? value) {
                if (valueValidator(value)) {
                  return 'Campo Vazio';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: widget.labelText,
              ),
            ),
          ),
        ),
        IconButton(
          enableFeedback: widget.enabled,
          onPressed: () {
            if (widget.enabled && widget.pickerValue < widget.max) {
              setState(() {
                widget.pickerValue += 1;
                widget.controller.text = widget.pickerValue.toString();
              });
                widget.action(widget.pickerValue);
            }
          },
          icon: const Icon(
            Icons.chevron_right_rounded,
          ),
        ),
      ],
    );
  }
}
