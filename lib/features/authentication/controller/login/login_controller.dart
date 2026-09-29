import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/features/personalization/screens/controller/user_controller.dart';

import 'package:e_commerce/utils/constants/keys.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:e_commerce/utils/popups/snackbar_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  //Vairables

  final email = TextEditingController();
  final password = TextEditingController();
  RxBool isPasswordVisible = false.obs;
  RxBool isRememberMe = true.obs;
  final loginFormKey = GlobalKey<FormState>();
  //local storage vairable
  final localStorage = GetStorage();
  //

  final _userController = Get.put(UserController());

  //intialization
  @override
  void onInit() {
    email.text = localStorage.read(Ukeys.rememberMeEmail) ?? '';
    password.text = localStorage.read(Ukeys.rememberMePassword) ?? '';

    super.onInit();
  }

  //login through the email & password
  Future<void> loginWithEmailAndPassword() async {
    try {
      //
      if (!loginFormKey.currentState!.validate()) {
        return;
      }
      //loading screen
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
      //

      //remember me check box=> if checkbox is true then we will store the data into local storage
      if (isRememberMe.value) {
        localStorage.write(Ukeys.rememberMeEmail, email.text);
        localStorage.write(Ukeys.rememberMePassword, password.text);
      }

      //login - login the user through email & password
      await AuthenticationRepository.instance.loginWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );
      UFullScreenLoader.stopLoading();
      //
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: e.toString());
    }
  }

  //Login with social button ->Google

  Future<void> googleSignIn() async {
    try {
      //start loading
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
      //google authentication

      UserCredential userCredential = await AuthenticationRepository.instance
          .signInWithGoogle();

      //saver user record
      await _userController.saveUserRecord(userCredential);
      //stop loading
      UFullScreenLoader.stopLoading();
      //redierect
      AuthenticationRepository.instance.screenRedirect();
    } on GoogleSignInException catch (e) {
      print('code: ${e.code}, description: ${e.description}');
    } catch (e) {
      //
      UFullScreenLoader.stopLoading();
      //
      USnackBarHelpers.errorSnackBar(title: e.toString());
    }
  }
  //
}
