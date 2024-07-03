import 'package:flutter/material.dart';

class AddTaskHeader extends StatelessWidget {
  const AddTaskHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(
          height: 20,
        ),
        const Center(
          child: Text(
            'Add Task',
            style: TextStyle(
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
