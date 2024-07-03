import 'package:do_todo/constant.dart';
import 'package:do_todo/core/widgets/color_items.dart';
import 'package:flutter/material.dart';

class BuildColorItem extends StatelessWidget {
  const BuildColorItem({
    super.key,
    required this.selectedColor,
    required this.onSelectColor,
  });

  final Color? selectedColor;
  final Function(Color) onSelectColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.separated(
        itemCount: backgroundColors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final color = backgroundColors[index];
          return ColorItem(
            color: color,
            isActive: color == selectedColor,
            onTap: onSelectColor,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 10,
          );
        },
      ),
    );
  }
}
