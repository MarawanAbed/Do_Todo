import 'package:do_todo/core/widgets/build_color_items.dart';
import 'package:flutter/material.dart';

class ColorsChoose extends StatelessWidget {
  const ColorsChoose({
    super.key,
    required this.selectedColor,
  });

  final ValueNotifier<Color?> selectedColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: ValueListenableBuilder<Color?>(
        valueListenable: selectedColor,
        builder: (context, value, child) {
          return SizedBox(
            height: 50,
            child: BuildColorItem(
              selectedColor: value,
              onSelectColor: (color) {
                selectedColor.value = color;
              },
            ),
          );
        },
      ),
    );
  }
}
