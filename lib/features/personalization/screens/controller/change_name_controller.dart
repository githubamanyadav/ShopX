import 'package:e_commerce/data/repository/user/user_repository.dart';
import 'package:e_commerce/features/personalization/screens/controller/user_controller.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:e_commerce/utils/popups/snackbar_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChangeNameController extends GetxController {
  //varaibale
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final updateUserFormkey = GlobalKey<FormState>();
  final _userController = UserController.instance;

  //
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  void initializeNames() {
    firstName.text = _userController.user.value.firstName;
    lastName.text = _userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
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
      //form validation
      if (!updateUserFormkey.currentState!.validate()) {
        //start loading
        UFullScreenLoader.stopLoading();
        return;
      }

      //update the fist & last name
      Map<String, dynamic> map = {
        "FirstName": firstName.text.trim(),
        "LastName": lastName.text.trim(),
      };

      await UserRepository.instance.uodateSingleField(map);
      //update the current user for the whole app
      _userController.user.value.firstName = firstName.text;
      _userController.user.value.lastName = lastName.text;

      //stop loading
      UFullScreenLoader.stopLoading();
      //redierect
      Get.offAll(() => NavigationMenu());
      //success message
      USnackBarHelpers.successSnackBar(
        title: "congratulations!",
        message: "Your Name has been Updated ",
      );
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(
        title: "update Name failed!!",
        message: e.toString(),
      );
    }
  }
}
