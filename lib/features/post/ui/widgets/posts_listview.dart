import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/app_size.dart';
import '../../../../core/widgets/app_empty_widget.dart';
import '../../../../core/widgets/app_pagination_loading_holder.dart';
import '../../../category/logic/category_cubit.dart';
import '../../logic/post_cubit.dart';
import '../../logic/post_state.dart';
import 'posts_listview_item.dart';

class PostsListview extends StatefulWidget {
  const PostsListview({super.key});

  @override
  State<PostsListview> createState() => _PostsListviewState();
}

class _PostsListviewState extends State<PostsListview> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    PostCubit.get.emitGetPosts();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        PostCubit.get.emitGetPosts(
          isPagination: true,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<PostCubit, PostState>(
        buildWhen: (previous, current) =>
            current is Loading ||
            current is Success ||
            current is Error ||
            current is Pagination,
        builder: (context, state) {
          var cubit = PostCubit.get;
          return RefreshIndicator(
            onRefresh: () async {
              CategoryCubit.get.resetSeletedItem();
              PostCubit.get.emitGetPosts(isRefresh: true);
              PostCubit.get.getLastIndex(0);
            },
            child: SizedBox(
              height: AppSize.fullHight(context),
              child: state is Loading
                  ? const Center(child: CircularProgressIndicator())
                  : cubit.postsList.isEmpty
                      ? Center(
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: AppEmptyWidget(
                              text: 'no_ads'.tr(context: context),
                            ),
                          ),
                        )
                      : ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: scrollController,
                          padding: EdgeInsets.only(
                            top: 10.h,
                            bottom: 20.h,
                            left: 2.w,
                            right: 2.w,
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
                              item: PostsListviewItem(
                                post: post,
                              ),
                            );
                          },
                        ),
            ),
          );
        },
      ),
    );
  }
}
