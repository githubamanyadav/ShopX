import 'package:e_commerce/features/authentication/controller/onboarding/onboarding_controller.dart';
import 'package:e_commerce/utils/helpers/device_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class OnboardingTextButton extends StatelessWidget {
  const OnboardingTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    return Positioned(
      top: UDeviceHelper.getAppBarHeight(),
      right: 0,

      child: Obx(
        () => TextButton(
          onPressed: controller.skipPage,
          child: Text(
            controller.currentIndex.value != 2 ? "Skip" : " ",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
