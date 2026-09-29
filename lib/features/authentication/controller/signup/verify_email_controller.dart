import 'dart:async';
import 'package:e_commerce/common/widget/screens/success_screen.dart';
import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/popups/snackbar_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class VerifyEmailController extends GetxController {
  //we write this in this way bcoz it make easy write the syntax of GEt.find()
  static VerifyEmailController get instance => Get.find();

  //as the cotnroller of this class get created it will run just after
  @override
  void onInit() {
    setTimeForAutoRedirect();
    sendEmailverification();
    super.onInit();
  }

  //

  //send email verification link to current user
  Future<void> sendEmailverification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();

      USnackBarHelpers.successSnackBar(
        title: "Email has sent",
        message: "please check your email box",
      );
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: "Error", message: e.toString());
    }
  }

  //verifying the email
  void setTimeForAutoRedirect() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser!.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
      }
      Get.off(
        () => SuccessScreen(
          title: UTexts.accountCreatedTitle,
          subtitle: UTexts.accountCreatedSubTitle,
          image: UImages.successfulPaymentIcon,
          onTap: () => AuthenticationRepository.instance.screenRedirect(),
        ),
      ); // SuccessScreen
    });
  }

  //manually check if email is verified or not
  Future<void> checkEmailverificationStatus() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null && currentUser.emailVerified) {
        Get.off(
          () => SuccessScreen(
            title: UTexts.accountCreatedTitle,
            subtitle: UTexts.accountCreatedSubTitle,
            image: UImages.successfulPaymentIcon,
            onTap: () => AuthenticationRepository.instance.screenRedirect(),
          ),
        ); // SuccessS
      }
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: e.toString());
    }
  }
}
