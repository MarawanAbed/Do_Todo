import 'package:do_todo/Do_Todo/data/models/todo_model.dart';
import 'package:do_todo/Do_Todo/domain/use_cases/search_tasks/search_tasks_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_tasks_cubit.freezed.dart';
part 'search_tasks_state.dart';

class SearchTasksCubit extends Cubit<SearchTasksState> {
  SearchTasksCubit(this._searchTasksUseCase)
      : super(const SearchTasksState.initial());

  final SearchTasksUseCase _searchTasksUseCase;

  void searchTasks(String query) async {
    try {
      var tasks = await _searchTasksUseCase.call(query);
      emit(SearchTasksState.loaded(tasks));
    } catch (error) {
      emit(SearchTasksState.error(error.toString()));
    }
  }
}
