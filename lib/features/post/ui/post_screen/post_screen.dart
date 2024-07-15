import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_global_app_bar.dart';
import '../../data/post_response_body.dart';
import '../widgets/post_details.dart';
import 'widgets/post_creator.dart';
import 'widgets/post_images.dart';

class PostScreen extends StatefulWidget {
  final PostResponseBody post;
  const PostScreen({
    super.key,
    required this.post,
  });

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                verticalSpace(20),
                const AppGlobalAppBar(title: 'Post'),
                verticalSpace(20),
                PostCreator(post: widget.post),
                verticalSpace(20),
                PostImages(
                  currentIndex: currentIndex,
                  images: widget.post.images ?? [],
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
                verticalSpace(20),
                PostDetails(
                  post: widget.post,
                  currentIndex: currentIndex,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
