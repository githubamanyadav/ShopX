import 'package:e_commerce/common/widget/button/elevated_button.dart';
import 'package:e_commerce/features/authentication/controller/onboarding/onboarding_controller.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardNextButton extends StatelessWidget {
  const OnBoardNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    return Positioned(
      left: USizes.defaultSpace,
      right: USizes.defaultSpace,
      bottom: USizes.spaceBtwItems * 3,
      child: UElevatedButton(
        onPressed: controller.nextPage,
        child: Obx(
          () =>
              Text(controller.currentIndex.value != 2 ? 'Next' : "Get started"),
        ),
      ),
    );
  }
}
