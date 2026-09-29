import 'package:e_commerce/data/repository/user/user_repository.dart';
import 'package:e_commerce/features/authentication/models/user.dart';
import 'package:e_commerce/utils/popups/snackbar_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  //vairables

  final _userRepository = Get.put(UserRepository());

  //function to convert a user credential type to dart user model type
  Future<void> saveUserRecord(UserCredential userCredential) async {
    try {
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
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: e.toString());
    }
  }
}
