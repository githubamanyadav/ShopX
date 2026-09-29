import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/features/authentication/models/user.dart';
import 'package:e_commerce/utils/constants/keys.dart';

import 'package:e_commerce/utils/exception/firebase_auth_exception.dart';
import 'package:e_commerce/utils/exception/firebase_exceptions.dart';
import 'package:e_commerce/utils/exception/format_exception.dart';
import 'package:e_commerce/utils/exception/platform_exception.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  //vairable
  final _db = FirebaseFirestore.instance;

  //storing the user model to firestore => this function is called by the signup cotnroller & GoogleSignin
  Future<void> saveUserRecord(UserModel userModel) async {
    try {
      await _db
          .collection(Ukeys.userCollection)
          .doc(userModel.id)
          .set(userModel.toJson());
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code);
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code);
    } catch (e) {
      throw "something went wrong. please try again";
    }
  }

  //fetching the data from the firestore
  Future<void> fetchUserDetails(UserModel userModel) async {
    try {
      await _db
          .collection(Ukeys.userCollection)
          .doc(userModel.id)
          .set(userModel.toJson());
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code);
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code);
    } catch (e) {
      throw "something went wrong. please try again";
    }
  }
}
