import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/features/authentication/models/user.dart';
import 'package:e_commerce/utils/constants/api.dart';
import 'package:e_commerce/utils/constants/keys.dart';
import 'package:e_commerce/utils/exception/firebase_auth_exception.dart';
import 'package:e_commerce/utils/exception/firebase_exceptions.dart';
import 'package:e_commerce/utils/exception/format_exception.dart';
import 'package:e_commerce/utils/exception/platform_exception.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart' as dio;

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
  Future<UserModel> fetchUserDetails() async {
    try {
      //this will fetch the user from the firestore database
      final documentSnapshot = await _db
          .collection(Ukeys.userCollection)
          .doc(AuthenticationRepository.instance.currentUser!.uid)
          .get();
      //  if the documnet snapshot exist then it will convert the snapshot data into Usermodel(dart format)
      if (documentSnapshot.exists) {
        UserModel user = UserModel.fromSnapshot(documentSnapshot);
        return user;
      }
      //otherwise return empty model
      return UserModel.empty();
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

  //[UPDATE] updating the first & last name
  Future<void> uodateSingleField(Map<String, dynamic> map) async {
    try {
      //this will fetch the user from the firestore database

      await _db
          .collection(Ukeys.userCollection)
          .doc(AuthenticationRepository.instance.currentUser!.uid)
          .update(map);
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

  //[Delete] deleting the user record
  Future<void> removeUserRecord(String userId) async {
    try {
      //this will fetch the user from the firestore database
      await _db.collection(Ukeys.userCollection).doc(userId).delete();
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

  //to upload image on the cloudinary
  Future<dio.Response> uploadImage(File image) async {
    try {
      final String api = UApiUrls.uploadApi(Ukeys.cloudName);

      final dio.FormData formData = dio.FormData.fromMap({
        'upload_preset': Ukeys.uploadPreset,
        'folder': Ukeys.profileFolder,
        'file': await dio.MultipartFile.fromFile(
          image.path,
          filename: image.path.split(Platform.pathSeparator).last,
        ),
      });

      final dio.Response response = await dio.Dio().post(api, data: formData);
      return response;
    } on dio.DioException catch (e) {
      throw e.response?.data?['error']?['message'] ??
          e.message ??
          'Image upload failed. Please try again.';
    } catch (e) {
      throw 'Something went wrong while uploading the image.';
    }
  }

  // {Delete} - image from the cloduinary
  Future<dio.Response> deleteProfileImage(String PublicId) async {
    try {
      //
      final String api = UApiUrls.deleteApi(Ukeys.cloudName);

      //
      int timeStamp = (DateTime.now().millisecondsSinceEpoch / 1000).round();
      //
      String signatureBase =
          'public_id=$PublicId&timestamp=$timeStamp${Ukeys.apiSecret}';

      //
      String signature = sha1.convert(utf8.encode(signatureBase)).toString();

      final dio.FormData formData = dio.FormData.fromMap({
        'public_id': PublicId,
        'api_key': Ukeys.apiKey,
        'timestamp': timeStamp,
        'signature': signature,
      });

      final dio.Response response = await dio.Dio().post(api, data: formData);
      return response;
    } on dio.DioException catch (e) {
      throw e.response?.data?['error']?['message'] ??
          e.message ??
          'Image upload failed. Please try again.';
    } catch (e) {
      throw 'Something went wrong while uploading the image.';
    }
  }
}
