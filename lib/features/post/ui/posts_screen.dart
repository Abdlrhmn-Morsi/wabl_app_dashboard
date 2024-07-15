import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wabl_app_dashboard/core/widgets/app_toggle_btns.dart';
import 'package:wabl_app_dashboard/features/post/bloc_listeners/update_post_bloc_listener.dart';
import 'package:wabl_app_dashboard/features/post/logic/post_cubit.dart';
import 'package:wabl_app_dashboard/features/post/logic/post_state.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/widgets/app_global_app_bar.dart';
import '../../bottom_nav_bar/logic/bottom_nav_bar_cubit.dart';
import 'widgets/posts_listview.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (v) {
        BottomNavBarCubit.get.changeIndex(0);
      },
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              const UpdatePostBlocListener(),
              verticalSpace(20),
              AppGlobalAppBar(
                title: 'Posts',
                isDefaultBackActive: false,
                onTapBack: () {
                  BottomNavBarCubit.get.changeIndex(0);
                },
              ),
              verticalSpace(20),
              BlocBuilder<PostCubit, PostState>(
                buildWhen: (previous, current) => current is GetLastIndex,
                builder: (context, state) {
                  var cubit = PostCubit.get;
                  return AppToggleBtns(
                    chosenIndex: cubit.lastTapedIndex,
                    titlesList: const [
                      'Pending',
                      'Approved',
                    ],
                    onTap: (index) {
                      PostCubit.get.getLastIndex(index);
                      PostCubit.get.emitGetPosts(
                        isEnabled: index == 0 ? false : true,
                        isRefresh: true,
                      );
                    },
                  );
                },
              ),
              const PostsListview(),
            ],
          ),
        )),
      ),
    );
  }
}
