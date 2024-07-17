import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/app_size.dart';
import '../../../../../core/widgets/app_empty_widget.dart';
import '../../../../../core/widgets/app_pagination_loading_holder.dart';
import '../../../../post/logic/current_user_posts_cubit.dart';
import '../../../../post/logic/current_user_posts_state.dart';
import 'profile_posts_listview_item.dart';

class ProfilePostsListview extends StatelessWidget {
  final String userId;
  const ProfilePostsListview({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserPostsCubit, CurrentUserPostsState>(
      buildWhen: (previous, current) =>
          current is Loading ||
          current is Success ||
          current is Error ||
          current is Pagination,
      builder: (context, state) {
        var cubit = CurrentUserPostsCubit.get;
        return state is Loading
            ? const Center(child: CircularProgressIndicator())
            : cubit.postsList.isEmpty
                ? SizedBox(
                    height: AppSize.fullHight(context) * .5,
                    child: AppEmptyWidget(
                      text: 'no_ads'.tr(context: context),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(
                      bottom: 20.h,
                    ),
                    separatorBuilder: (_, i) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: const Divider(),
                    ),
                    itemCount: cubit.postsList.length,
                    itemBuilder: (context, index) {
                      var post = cubit.postsList[index];
                      return AppPaginationLoadingHolder(
                        index: index,
                        isLoadingMore: cubit.isLoadingMore,
                        isReachedEnd: cubit.isReachedEnd,
                        listLength: cubit.postsList.length,
                        item: ProfilePostsListviewItem(
                          post: post,
                          index: index,
                        ),
                      );
                    },
                  );
      },
    );
  }
}
