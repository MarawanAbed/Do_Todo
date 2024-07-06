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
    var dark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<DarkThemeCubit, DarkThemeState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                context.read<DarkThemeCubit>().changeTheme(!state.isDark);
              },
              child: Icon(
                Icons.dark_mode_outlined,
                color: state.isDark ? Colors.white : Colors.black,
              ),
            );
          },
        ),
        Text(
          'Do Todo',
          style: TextStyle(
            color: dark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            CupertinoIcons.search,
            size: 30,
            color: dark ? Colors.white : Colors.black,
          ),
        )
      ],
    );
  }
}
