import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/features/shop/models/banner/banner_model.dart';

import 'package:e_commerce/utils/constants/keys.dart';
import 'package:e_commerce/utils/exception/firebase_exceptions.dart';
import 'package:e_commerce/utils/exception/format_exception.dart';
import 'package:e_commerce/utils/exception/platform_exception.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../services/cloudinary_services.dart';
import 'package:dio/dio.dart' as dio;

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  /// [UploadBanners] - Function to upload list of banners
  Future<void> uploadBanners(List<BannerModel> banners) async {
    try {
      for (final banner in banners) {
        // convert assetPath to File
        File image = await UHelperFunction.assetToFile(banner.imageUrl);

        // upload banner image to cloudinary
        dio.Response response = await _cloudinaryServices.uploadImage(
          image,
          Ukeys.bannersFolder,
        );
        if (response.statusCode == 200) {
          banner.imageUrl = response.data['url'];
        }

        await _db.collection(Ukeys.bannerCollection).doc().set(banner.toJson());

        print("Banner uploaded${banner.targetScreen}");
      }
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [FetchBanners] - Function to fetch all active banners only
  Future<List<BannerModel>> fetchActiveBanners() async {
    try {
      final query = await _db
          .collection(Ukeys.bannerCollection)
          .where('active', isEqualTo: true)
          .get();
      if (query.docs.isNotEmpty) {
        List<BannerModel> banners = query.docs
            .map((document) => BannerModel.fromDocument(document))
            .toList();
        return banners;
      }

      return [];
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
