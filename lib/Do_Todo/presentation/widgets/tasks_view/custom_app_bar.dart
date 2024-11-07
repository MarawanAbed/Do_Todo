import 'package:do_todo/Do_Todo/presentation/bloc/theme/themes_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'مؤسسة حياة',
          style: TextStyle(
            color:Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        PopupMenuButton<String>(
          onSelected: (String result) {
            // Handle the selected option
            print(result);
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Option 1',
              child: Text('نسخة احتياطية'),
            ),
            const PopupMenuItem<String>(
              value: 'Option 2',
              child: Text('استرداد النسخة الاحتياطية'),
            ),
          ],
        ),
      ],
    );
  }
}
