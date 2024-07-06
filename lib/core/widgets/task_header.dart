import 'package:flutter/material.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader({
    super.key,
    required this.title,
    required this.onBack,
    required this.dark,
  });

  final String title;
  final VoidCallback onBack;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon:
                Icon(Icons.arrow_back, color: dark ? Colors.white : Colors.black),
            onPressed: onBack,
          ),
          const SizedBox(
            width: 60,
          ),
          Text(
            title,
            style:  TextStyle(
              color: dark?Colors.white:Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}
