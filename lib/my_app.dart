import 'package:e_commerce/bindings/bindings.dart';
import 'package:e_commerce/routes/app_routes.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: UAppRoutes.screens,
      themeMode: ThemeMode.system,
      theme: UAppTheme.lightTheme,
      darkTheme: UAppTheme.darkTheme,
      initialBinding: UBindings(),
      home: Scaffold(
        backgroundColor: UColors.primary,
        body: Center(child: CircularProgressIndicator(color: UColors.white)),
      ),
    );
  }
}
