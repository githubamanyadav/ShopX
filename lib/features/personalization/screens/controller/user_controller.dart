import 'dart:io';

import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/data/repository/user/user_repository.dart';
import 'package:e_commerce/features/authentication/models/user.dart';
import 'package:e_commerce/features/authentication/screens/login/login_screen.dart';
import 'package:e_commerce/features/personalization/screens/edit%20profile/widgets/re_authenticate_user_form.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:e_commerce/utils/popups/snackbar_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

class UserController extends GetxController {
  static UserController get instance => Get.find();
  //vairables

  final _userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  RxBool profileLoading = false.obs;

  /// Re-Authenticate Form Variables
  final email = TextEditingController();
  final password = TextEditingController();
  final reAuthFormKey = GlobalKey<FormState>();
  RxBool isPasswordVisible = false.obs;
  RxBool isProfileUploading = false.obs;

  //this will makesure that whenver this class get into use through Get.put(Usercontroller) then first call this fx & fetch the data
  @override
  void onInit() {
    fetchUserDeatils();
    super.onInit();
  }

  //function to convert a user credential type to dart user model type
  Future<void> saveUserRecord(UserCredential userCredential) async {
    try {
      // first update the RX user model, then check if the user data is stored or not if not then store
      await fetchUserDeatils();
      if (user.value.id.isEmpty) {
        // name part-> it will serpate first name & last name in separate list
        final nameParts = UserModel.nameParts(userCredential.user!.displayName);
        final username = '${userCredential.user!.displayName}2345859';
        //converting user credential to usermodel
        UserModel userModel = UserModel(
          id: userCredential.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join('') : '',
          username: username,
          email: userCredential.user!.email ?? ' ',
          phoneNumber: userCredential.user!.phoneNumber ?? ' ',
          profilePicture: userCredential.user!.photoURL ?? ' ',
        );

        await _userRepository.saveUserRecord(userModel);
      }
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: e.toString());
    }
  }

  //Function to fetch User Deatils
  Future<void> fetchUserDeatils() async {
    try {
      // this user details will go to the above user variable
      profileLoading.value = true;
      UserModel user = await _userRepository.fetchUserDetails();

      this.user(user);
    } catch (e) {
      UserModel.empty();
    } finally {
      profileLoading.value = false;
    }
  }

  //to show pop up dialog box the delete & cancel button for confirmation
  void deleteAccountWarningPopup(BuildContext context) {
    final dark = UHelperFunction.isDarkMode(context);
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(USizes.md),
      backgroundColor: dark ? UColors.black : UColors.white,
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete account permanently?',
      confirm: ElevatedButton(
        onPressed: () {
          deleteUserAccount();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: USizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Get.back(),
        child: const Text('Cancel'),
      ),
    );
  }

  //this check what kind of login has been done then accordingly it will delete the account
  Future<void> deleteUserAccount() async {
    try {
      // Start Loading
      UFullScreenLoader.openLoadingDialog();

      // Re-Authenticate User
      final authRepository = AuthenticationRepository.instance;
      final provider = authRepository.currentUser!.providerData
          .map((e) => e.providerId)
          .first;

      // If Google Provider
      if (provider == 'google.com') {
        await authRepository.signInWithGoogle();
        await authRepository.deleteAccount();
        UFullScreenLoader.stopLoading();
        Get.offAll(() => LoginScreen());

        // If Email & Password Provider
      } else if (provider == 'password') {
        UFullScreenLoader.stopLoading();
        Get.to(() => ReAuthLoginForm());
        // where the user re-enters their email and password.
      }
    } catch (e) {
      // Screenshot ends here, so this part is my completion
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.warningSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
    }
  }

  //if the user is not isgned from google provider then  it would be email & paaswrod signin so in order to delete we make sure that it is the same user so that's it is getting reauthenticate
  Future<void> reAuthenticateUser() async {
    try {
      // Start Loading
      UFullScreenLoader.openLoadingDialog();

      // Check Internet Connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!reAuthFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

      // Re Authenticate User with email and password
      await AuthenticationRepository.instance
          .reauthenticateUserEmailWithPassword(
            email.text.trim(),
            password.text.trim(),
          );

      //delete the account
      await AuthenticationRepository.instance.deleteAccount();

      //
      UFullScreenLoader.stopLoading();
      //
      Get.offAll(() => LoginScreen());
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.warningSnackBar(
        title: 'email password is inncorrect',
        message: e.toString(),
      );
    }
  }

  //{UPDATING} the image from the cloudinary
  Future<void> updateUserprofilePicture() async {
    try {
      //is profile image is uploading - for shimmer effect
      isProfileUploading.value = true;
      //pick the image from the local gallery
      XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (image == null) return;

      //convert xfile to file
      File file = File(image.path);
      //
      if (user.value.publicId.isNotEmpty) {
        await _userRepository.deleteProfileImage(user.value.publicId);
      }

      //upload the picture to cloduinary
      dio.Response response = await _userRepository.uploadImage(file);

      //if the image is uploaded properly then
      if (response.statusCode == 200) {
        final data = response.data;
        final imageUrl = data['url'];
        //stroing purpose of the public is to when the user delete his account then his profile picture can be deleted from cloudinary
        final publicId = data['public_id'];
        //to upload profile picture to firestore
        await _userRepository.uodateSingleField({
          'ProfilePicture': imageUrl,
          'publicId': publicId,
        });
        //updating the current user profile picture & publicId
        user.value.profilePicture = imageUrl;
        user.value.publicId = publicId;

        user.refresh();
        //
        USnackBarHelpers.successSnackBar(title: "congrulations");
      } else {
        throw "Failed to upload profile picture. please try again";
      }

      //
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.warningSnackBar(
        title: 'email password is inncorrect',
        message: e.toString(),
      );
    } finally {
      isProfileUploading.value = false;
    }
  }
}
