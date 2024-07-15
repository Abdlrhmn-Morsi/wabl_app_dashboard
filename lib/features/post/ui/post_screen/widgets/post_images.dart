import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/app_size.dart';
import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/widgets/app_cach_image.dart';
import '../../../../../core/widgets/app_img_full_screen.dart';
import '../../widgets/image_indicators.dart';

class PostImages extends StatelessWidget {
  final List<String> images;
  final int currentIndex;
  final void Function(int)? onPageChanged;
  const PostImages({
    super.key,
    required this.images,
    this.onPageChanged,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return images.isEmpty
        ? const SizedBox.shrink()
        : SizedBox(
            height: AppSize.fullHight(context) * .4,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PageView.builder(
                  onPageChanged: onPageChanged,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        AppImgFullScreen(image: images[index])
                            .goOnWidget(context);
                      },
                      child: Hero(
                        tag: images[index],
                        child: AppCachImage(
                          image: images[index],
                          isNoBaseUrl: true,
                          isNotCircle: true,
                          height: AppSize.fullHight(context),
                          width: AppSize.fullWidth(context),
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  right: 10.w,
                  top: 10.h,
                  child: ImageIndicators(
                    length: images.length,
                    currentIndex: currentIndex,
                  ),
                ),
              ],
            ),
          );
  }
}
