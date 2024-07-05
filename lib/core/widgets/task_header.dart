import 'package:flutter/material.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader({
    super.key, required this.title, required this.onBack,
  });
  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
        const SizedBox(
          height: 20,
        ),
         Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      ],
    );
  }
}
