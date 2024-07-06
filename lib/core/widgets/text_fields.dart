import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  const TextFields({
    super.key,
    required this.title,
    required this.controller,
    required this.hint,
    this.readable,
    this.suffixIcon,  this.onChanged,
  });

  final String title;
  final String hint;
  final TextEditingController controller;
  final bool? readable;
  final Widget? suffixIcon;
  final VoidCallback? onChanged;
  @override
  Widget build(BuildContext context) {
    var dark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: dark?Colors.white:Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          onChanged: (value) {
            onChanged!();
          },
          readOnly: readable ?? false,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please Enter $title';
            }
            return null;
          },
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: dark?Colors.white:Colors.black,
            ),
            suffixIcon: suffixIcon,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}