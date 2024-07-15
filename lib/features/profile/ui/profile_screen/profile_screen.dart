import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_dashed_divider.dart';
import '../../../post/data/post_response_body.dart';
import '../../../post/logic/current_user_posts_cubit.dart';
import 'widgets/profile_app_ber.dart';
import 'widgets/profile_posts_listview.dart';
import 'widgets/profile_view_data.dart';

class ProfileScreen extends StatefulWidget {
  final PostOwner postOwner;
  const ProfileScreen({
    super.key,
    required this.postOwner,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    CurrentUserPostsCubit.get.resetData();
    CurrentUserPostsCubit.get.emitGetPosts(
      userId: widget.postOwner.id ?? "",
    );
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        CurrentUserPostsCubit.get.emitGetPosts(
          isPagination: true,
          userId: widget.postOwner.id ?? "",
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: RefreshIndicator(
            onRefresh: () async {
              await CurrentUserPostsCubit.get.emitGetPosts(
                isRefresh: true,
                userId: widget.postOwner.id ?? "",
              );
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              child: Column(
                children: [
                  verticalSpace(20),
                  ProfileAppBar(
                    postOwner: widget.postOwner,
                  ),
                  verticalSpace(20),
                  ProfileViewData(
                    postOwner: widget.postOwner,
                  ),
                  verticalSpace(20),
                  const AppDividerDashed(),
                  verticalSpace(20),
                  ProfilePostsListview(
                    userId: widget.postOwner.id ?? "",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
