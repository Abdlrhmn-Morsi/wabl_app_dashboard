import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wabl_app_dashboard/features/auth/logic/auth_helper.dart';
import '../../../core/theming/colors.dart';
import '../logic/bottom_nav_bar_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      buildWhen: (previous, current) => current is ChangeIndexState,
      builder: (context, state) {
        var cubit = BottomNavBarCubit.get;
        return Scaffold(
          body: cubit.pages()[cubit.currentIndex],
          bottomNavigationBar: AnimatedOpacity(
            opacity: cubit.isScrollingDown ? 0 : 1,
            duration: const Duration(milliseconds: 400),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: cubit.isScrollingDown ? 0 : null,
              child: CustomNavigationBar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                currentIndex: cubit.currentIndex,
                unSelectedColor: Colors.grey.shade400,
                selectedColor: ColorsManager.mainColor,
                strokeColor: ColorsManager.mainBoldColor,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: AuthHelper.isSuperAdmin()
                    ? [
                        CustomNavigationBarItem(
                          icon: const Icon(Icons.home),
                        ),
                        CustomNavigationBarItem(
                          icon: const Icon(Icons.post_add),
                        ),
                        CustomNavigationBarItem(
                            icon: const Icon(
                          Icons.person,
                        )),
                        CustomNavigationBarItem(
                          icon: const Icon(Icons.settings),
                        ),
                      ]
                    : [
                        CustomNavigationBarItem(
                          icon: const Icon(Icons.home),
                        ),
                        CustomNavigationBarItem(
                          icon: const Icon(Icons.post_add),
                        ),
                        CustomNavigationBarItem(
                          icon: const Icon(Icons.settings),
                        ),
                      ],
              ),
            ),
          ),
        );
      },
    );
  }
}
