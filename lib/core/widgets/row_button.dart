import 'package:do_todo/core/widgets/colors_choose.dart';
import 'package:flutter/material.dart';

class RowButton extends StatelessWidget {
  const RowButton({super.key, required this.selectedColor, required this.onTap, required this.title});
  final ValueNotifier<Color?> selectedColor;
  final String title;
  final void Function()  onTap;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: (){
            onTap();
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
            ),
            child: const Text(
              'Edit Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
