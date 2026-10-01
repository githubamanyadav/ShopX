import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/features/authentication/screens/forget_password.dart/reset_password.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:e_commerce/utils/popups/snackbar_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  //variables
  final email = TextEditingController();
  final forgetPasswordFormKey = GlobalKey<FormState>();

  //send email to reset the password
  Future<void> sendPasswordResetEmail() async {
    try {
      //reset the email from the repository
      await AuthenticationRepository.instance.sendPasswordResetEmail(
        email.text.trim(),
      );
      //
      UFullScreenLoader.stopLoading();
      //
      USnackBarHelpers.successSnackBar(
        title: "Email sent",
        message: "Email is Successfully sent to your mail",
      );

      //navigate to the reset screen
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(
        title: "forget password failed",
        message: e.toString(),
      );
    }
  }

  //send email to reset the password
  Future<void> resendPasswordResetEmail() async {
    try {
      //start loading screen
      UFullScreenLoader.openLoadingDialog();

      //check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //stop loading screen
        UFullScreenLoader.stopLoading();
        // error for the internet connection
        USnackBarHelpers.warningSnackBar(title: "No internet Connection");
        return;
      }

      //reset the email from the repository
      await AuthenticationRepository.instance.sendPasswordResetEmail(
        email.text.trim(),
      );
      //
      UFullScreenLoader.stopLoading();
      //
      USnackBarHelpers.successSnackBar(
        title: "Email sent",
        message: "Email is Successfully sent to your mail",
      );
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(
        title: "forget password failed",
        message: e.toString(),
      );
    }
  }
}
