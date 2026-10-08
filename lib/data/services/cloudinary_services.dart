import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:e_commerce/utils/constants/api.dart';
import 'package:e_commerce/utils/constants/keys.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class CloudinaryServices extends GetxController {
  static CloudinaryServices get instance => Get.find();

  //variable
  final _dio = dio.Dio();

  //{UPLOAD}to upload image on the cloudinary
  Future<dio.Response> uploadImage(File image, String FolderName) async {
    try {
      final String api = UApiUrls.uploadApi(Ukeys.cloudName);

      final dio.FormData formData = dio.FormData.fromMap({
        'upload_preset': Ukeys.uploadPreset,
        'folder': FolderName,
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
  Future<dio.Response> deleteImage(String PublicId) async {
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
