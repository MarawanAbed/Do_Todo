
import 'package:do_todo/core/di/di.dart';
import 'package:do_todo/core/helpers/cached.dart';
import 'package:do_todo/core/utils/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'themes_state.dart';

class DarkThemeCubit extends Cubit<DarkThemeState> {
  DarkThemeCubit() : super(DarkThemeState());


  Future<void> getSavedTheme() async {
    final theme = await getIt<SharedPreCacheHelper>().getData(key: darkKey)??false;
    emit(DarkThemeState(isDark: theme));
  }

  Future<void> changeTheme(bool theme) async {
    await getIt<SharedPreCacheHelper>().saveData(key: darkKey, value: theme);
    emit(DarkThemeState(isDark: theme));
  }
}