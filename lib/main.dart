import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/firebase_options.dart';
import 'package:e_commerce/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  //widget binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  //firebase setting
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // flutter splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //Get storage intialization
  await GetStorage.init();

  //firbase intialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    Get.put(AuthenticationRepository());
  });

  //potrait  up the device
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}
