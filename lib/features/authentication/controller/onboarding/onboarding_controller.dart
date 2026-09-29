import 'package:e_commerce/features/authentication/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingController extends GetxController {
  //don't need to create a object of this
  static OnBoardingController get instance => Get.find();

  //vairbales
  final storage = GetStorage();

  //pageController has full control of the PageView widget.
  final pageController = PageController();
  RxInt currentIndex = 0.obs;

  //update current index as per page scrolls
  void updatePageIndicator(index) {
    currentIndex.value = index;
  }

  //jump to specific dot selected page
  void dotNAvigationClick(index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  //update current index & jump to the next
  void nextPage() {
    if (currentIndex.value == 2) {
      storage.write("isFirstTime", false);
      Get.off(() => LoginScreen());
      return;
    }
    currentIndex.value++;
    pageController.jumpToPage(currentIndex.value);
  }

  //update current index & jump to the last page
  void skipPage() {
    currentIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
