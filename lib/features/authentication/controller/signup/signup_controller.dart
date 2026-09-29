import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/data/repository/user/user_repository.dart';
import 'package:e_commerce/features/authentication/models/user.dart';
import 'package:e_commerce/features/authentication/screens/signup/email_verify.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:e_commerce/utils/popups/snackbar_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //variables
  final signUpformKey = GlobalKey<FormState>();
  // we have already made get.put(authRepostory()) into  main.dart file @gmail.com
  // final _authRepository = Get.put(AuthenticationRepository());

  //form textField controller variables
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();

  //
  RxBool isPasswordVisible = false.obs;
  RxBool privacyPolicy = false.obs;

  //function to register with user & email & password
  Future<void> registerUser() async {
    try {
      //validating the form -> checking all the fields are correct or not
      if (!signUpformKey.currentState!.validate()) {
        return;
      }
      UFullScreenLoader.openLoadingDialog();
      //checking the internet connection is there or not
      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: 'NO internet connection');
        return;
      }

      //check privacy policy
      if (!privacyPolicy.value) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(
          title: "Accept privacy policy",
          message:
              "In order to create account to need to check the privacy policy ",
        );
        return;
      }

      //registring the using firebase -> if all the field are correct then register through the repository
      UserCredential userCredential = await AuthenticationRepository.instance
          .registerUser(email.text.trim(), password.text.trim());

      //creating the user model
      UserModel userModel = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text,
        lastName: lastName.text,
        username: '${firstName.text}${lastName.text}12323',
        email: email.text,
        phoneNumber: phoneNumber.text,
        profilePicture: '',
      );

      //save user model to the fire store  using userrepostory
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(userModel);
      //success message

      USnackBarHelpers.successSnackBar(
        title: "congrulations",
        message: " Your account has been created successfully",
      );
      //stop loading
      UFullScreenLoader.stopLoading();
      //redierect to the email verfiy screen cause it is firsttime is making
      Get.to(() => EmailVerifyScreen(email: email.text));
    } catch (e) {
      //stop loading
      UFullScreenLoader.stopLoading();
      //
      USnackBarHelpers.errorSnackBar(title: "Error", message: e.toString());
    }
  }
}
