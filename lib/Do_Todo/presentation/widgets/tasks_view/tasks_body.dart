import 'package:do_todo/Do_Todo/presentation/bloc/get_tasks/get_tasks_cubit.dart';
import 'package:do_todo/Do_Todo/presentation/widgets/tasks_view/custom_app_bar.dart';
import 'package:do_todo/Do_Todo/presentation/widgets/tasks_view/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'build_notes_item.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({
    super.key,
  });

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    context.read<GetTasksCubit>().getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(),
                SizedBox(
                  height: 20,
                ),
                Header(),
                SizedBox(
                  height: 20,
                ),
                BuildNotesItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
