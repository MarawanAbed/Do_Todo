import 'package:do_todo/Do_Todo/presentation/pages/add_task/add_task_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          DateFormat('MMMM d,yyyy EEEE','ar').format(DateTime.now()),
          style:  TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
