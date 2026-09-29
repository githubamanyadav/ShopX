import 'package:e_commerce/features/shop/controller/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingNavigation extends StatelessWidget {
  const OnBoardingNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return Positioned(
      child: Obx(
        () => SmoothPageIndicator(
          controller: PageController(
            initialPage: controller.currentIndex.value,
          ),
          count: 3,
          effect: const ExpandingDotsEffect(dotHeight: 6.0),
        ),
      ),
    );
  }
}
