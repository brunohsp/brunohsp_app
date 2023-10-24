import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final String title;
  final Widget child;
  final FontWeight weight;
  final double size;
  final bool noMargin;
  final double titlePadding;
  final IconButton? iconButton;
  const Section({
    required this.title,
    required this.child,
    this.weight = FontWeight.bold,
    this.size = 24,
    this.noMargin = false,
    this.titlePadding = 16,
    this.iconButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: noMargin
          ? null
          : const EdgeInsets.only(top: 32, right: 16, left: 16, bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(bottom: titlePadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: size, fontWeight: weight),
                  ),
                  Container(
                    child: iconButton,
                  )
                ],
              )),
          child,
        ],
      ),
    );
  }
}
