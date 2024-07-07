import 'package:do_todo/Do_Todo/presentation/bloc/search_tasks/search_tasks_cubit.dart';
import 'package:do_todo/core/widgets/notes_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTaskBody extends StatefulWidget {
  const SearchTaskBody({super.key});

  @override
  State<SearchTaskBody> createState() => _SearchTaskBodyState();
}

class _SearchTaskBodyState extends State<SearchTaskBody> {
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dark=Theme.of(context).brightness==Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextFormField(
            controller: _searchController,
            onChanged: (val) {
              if(val.isNotEmpty)
              {
                context.read<SearchTasksCubit>().searchTasks(val);
              }else
              {
                context.read<SearchTasksCubit>().emit(const SearchTasksState.initial());
              }
            },
            decoration: const InputDecoration(
              labelText: 'Search Task',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<SearchTasksCubit, SearchTasksState>(
            builder: (context, state) {
              return state.when(
                initial: () =>  Expanded(
                  child: Center(
                    child: Text('Search for a task',style: TextStyle(
                      color: dark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),),
                  ),
                ),
                loaded: (tasks)=>ListView.separated(
                  shrinkWrap: true,
                  itemCount: tasks.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (context, index) {
                    return NotesItems(
                      todoModel: tasks[index],
                    );
                  },
                ),
                error: (message) => Center(
                  child: Text(message,style: TextStyle(
                    color: dark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
