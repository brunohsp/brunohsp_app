// ignore_for_file: must_be_immutable

import 'package:brunohsp_app/controllers/calculate.dart';
import 'package:brunohsp_app/controllers/widgets/avatars/dice_avatar.dart';
import 'package:brunohsp_app/models/dice_roll.dart';
import 'package:brunohsp_app/repositories/dices_repository.dart';
import 'package:brunohsp_app/widgets/utils/number_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class DiceAvatar extends StatefulWidget {
  final String url;
  final Color color;
  final int sides;
  late List<int> results = [];
  DiceAvatar(
      {required this.url,
      required this.sides,
      this.color = Colors.black,
      Key? key})
      : super(key: key);

  TextEditingController rollsController = TextEditingController();
  TextEditingController incrementController = TextEditingController();

  @override
  State<DiceAvatar> createState() => _DiceAvatarState();
}

class _DiceAvatarState extends State<DiceAvatar> {
  late DicesRepository repository;

  diceModal() {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height:  300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Lançando D${widget.sides}',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    )),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: NumberPicker(
                    labelText: "Incremento",
                    controller: widget.incrementController,
                    max: 100,
                    min: 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: NumberPicker(
                    labelText: "Lançamentos",
                    controller: widget.rollsController,
                    max: 10,
                    min: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Calculate.widthWithColumns(
                          2, MediaQuery.of(context).size.width),
                      child: FilledButton(
                        onPressed: () {
                          // TODO: CHANGE RESULTS VISUALISATION

                          widget.results = DiceAvatarController.throwDices(
                              int.parse(widget.rollsController.text),
                              widget.sides,
                              int.parse(widget.incrementController.text));

                          repository.saveRoll(DiceRoll(
                            dice: 'D${widget.sides}',
                            times: int.parse(widget.rollsController.text),
                            addition:
                                int.parse(widget.incrementController.text),
                            results: widget.results,
                          ));

                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'OLHA O DAAAADO: ${widget.results.toString()}',
                                textAlign: TextAlign.center,
                              ),
                              duration: const Duration(milliseconds: 3000),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical:
                                      8.0 // Inner padding for SnackBar content.
                                  ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          );
                        },
                        child: const Text('Jogar'),
                      ),
                    ),
                    SizedBox(
                      width: Calculate.widthWithColumns(
                          2, MediaQuery.of(context).size.width),
                      child: OutlinedButton(
                        child: const Text('Cancelar'),
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

  @override
  Widget build(BuildContext context) {
    repository = context.read<DicesRepository>();

    return IconButton(
      onPressed: () {
        diceModal();
      },
      icon: SvgPicture.asset(widget.url, color: widget.color),
    );
  }
}
