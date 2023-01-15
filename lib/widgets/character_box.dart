import 'package:flutter/material.dart';

class CharacterBox extends StatelessWidget {
  final VoidCallback onTap;
  final bool isCurrentBox;

  const CharacterBox(
      {super.key, required this.onTap, this.isCurrentBox = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
            color: isCurrentBox ? Colors.limeAccent : Colors.white,
            borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}
