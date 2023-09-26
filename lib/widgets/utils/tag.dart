import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final Widget badge;
  final String label;

  const Tag({required this.badge, required this.label, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children:[
          Padding(padding: const EdgeInsets.only(right: 4),
          child: badge,
          ),
          Text(label, style: const TextStyle(fontSize: 12))
        ]
      ),
    );

  }
}
