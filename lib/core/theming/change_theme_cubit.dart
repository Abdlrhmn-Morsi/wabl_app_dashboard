import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import '../helpers/app_local_storage.dart';
import '../helpers/app_saved_key.dart';
import 'dark_theme.dart';
import 'light_theme.dart';
part 'change_theme_state.dart';

class ChangeThemeCubit extends Cubit<ChangeThemeState> {
  ChangeThemeCubit() : super(ChangeThemeInitState());
  static ChangeThemeCubit get(context) => BlocProvider.of(context);

  void toggleDarkMode(bool value) {
    ApplocalStorage.saveBool(AppSavedKey.isDarkMode, value);
    emit(IsDarkModeState());
  }

  bool isDarkMode() {
    return ApplocalStorage.getBool(AppSavedKey.isDarkMode);
  }

  ThemeData themeData() {
    return ApplocalStorage.getBool(AppSavedKey.isDarkMode) ? dark() : light();
  }
}
