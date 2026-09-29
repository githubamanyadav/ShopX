// ignore: camel_case_types
import 'package:e_commerce/features/authentication/controller/onboarding/onboarding_controller.dart';
import 'package:e_commerce/utils/helpers/device_helper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: camel_case_types
class onBoardingNavigation extends StatelessWidget {
  const onBoardingNavigation({super.key, required this._pageController});

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    final Controller = OnBoardingController.instance;
    return Positioned(
      bottom: UDeviceHelper.getBottomNavigationBarHeight() * 6,
      left: UDeviceHelper.getScreenWidth(context) / 2.5,
      right: UDeviceHelper.getScreenWidth(context) / 2.5,
      child: SmoothPageIndicator(
        onDotClicked: (index) => Controller.dotNAvigationClick(index),
        controller: _pageController,
        count: 3,
        effect: const ExpandingDotsEffect(dotHeight: 6.0),
      ),
    );
  }
}
