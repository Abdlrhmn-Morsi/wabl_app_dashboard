import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wabl_app_dashboard/features/auth/logic/auth_helper.dart';
import 'package:wabl_app_dashboard/features/users/ui/users_screen.dart';
import '../../../core/di/dependency_injection.dart';
import '../../home/ui/home_screen.dart';
import '../../post/ui/posts_screen.dart';
import '../../settings/ui/settings_screen.dart';
part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarInItState());
  static BottomNavBarCubit get get => getIt();
  int currentIndex = 0;

  List<Widget> pages() {
    return AuthHelper.isSuperAdmin()
        ? [
            const HomeScreen(),
            const PostsScreen(),
            const UsersScreen(),
            const SettingsScreen(),
          ]
        : [
            const HomeScreen(),
            const PostsScreen(),
            const SettingsScreen(),
          ];
  }

  void changeIndex(int index) {
    currentIndex = index;

    emit(ChangeIndexState());
  }

  var isScrollingDown = false;
  void getIsScrollingDown(bool v) {
    isScrollingDown = v;
    emit(ChangeIndexState());
  }
}
