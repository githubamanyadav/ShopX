import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerDotNavigation extends StatelessWidget {
  const BannerDotNavigation({
    super.key,
    required this.currentIndex,
    required this.dotCount,
  });

  final RxInt currentIndex;
  final int dotCount;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => AnimatedSmoothIndicator(
          activeIndex: currentIndex.value,
          count: dotCount,
          effect: const ExpandingDotsEffect(dotHeight: 6.0),
        ),
      ),
    );
  }
}
