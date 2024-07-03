import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  const TextFields({
    super.key,
    required this.title,
    required this.controller,
    required this.hint,
    this.readable,
    this.suffixIcon,
  });

  final String title;
  final String hint;
  final TextEditingController controller;
  final bool? readable;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
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