import 'package:brunohsp_app/controllers/calculate.dart';
import 'package:flutter/material.dart';

class DefaultCard extends StatelessWidget {
  final int columns;
  final Widget? child;
  final void Function()? onTap;

  const DefaultCard(
      {required this.columns, required this.child, this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width =
        Calculate.widthWithColumns(columns, MediaQuery.of(context).size.width);

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 32,
        right: 16,
      ),
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: Theme.of(context).colorScheme.onPrimary,
        child: InkWell(
          splashColor: Theme.of(context).colorScheme.primary,
          onTap: onTap,
          child: Container(
            width: width,
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}
