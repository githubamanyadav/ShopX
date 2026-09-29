import 'package:e_commerce/features/authentication/controller/onboarding/onboarding_controller.dart';
import 'package:e_commerce/features/authentication/screens/onboarding/Widgets/Onboarding_next_button.dart';

import 'package:e_commerce/features/authentication/screens/onboarding/Widgets/on_boarding_page.dart';
import 'package:e_commerce/features/authentication/screens/onboarding/Widgets/onboarding_navigation.dart';
import 'package:e_commerce/features/authentication/screens/onboarding/Widgets/onboarding_text_button.dart';
import 'package:e_commerce/utils/constants/images.dart';

import 'package:e_commerce/utils/constants/text.dart';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            // scrollDirection: Axis.vertical,
            controller: controller.pageController,
            children: [
              OnBoardingPage(
                animation: UImages.onboarding1Animation,
                title: UTexts.onBoardingTitle1,
                subTitle: UTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                animation: UImages.onboarding2Animation,
                title: UTexts.onBoardingTitle3,
                subTitle: UTexts.onBoardingSubTitle3,
              ),
              OnBoardingPage(
                animation: UImages.onboarding3Animation,
                title: UTexts.onBoardingTitle2,
                subTitle: UTexts.onBoardingSubTitle2,
              ),
            ],
          ),

          /// Indicator
          onBoardingNavigation(pageController: controller.pageController),

          // button
          OnBoardNextButton(),

          //text button skip
          OnboardingTextButton(),
        ],
      ),
    );
  }
}
