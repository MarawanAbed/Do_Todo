import 'package:flutter/material.dart';

class RowDetails extends StatelessWidget {
  const RowDetails({
    super.key,
    required this.body,
    required this.title,
    required this.icon,
  });

  final String body;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 40,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          body,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
