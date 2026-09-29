import 'package:e_commerce/common/style/padding.dart';
import 'package:e_commerce/features/authentication/controller/login/login_controller.dart';
import 'package:e_commerce/features/authentication/screens/login/widgets/divider.dart';
import 'package:e_commerce/features/authentication/screens/login/widgets/header.dart';
import 'package:e_commerce/features/authentication/screens/login/widgets/loginForm.dart';
import 'package:e_commerce/features/authentication/screens/login/widgets/social_button.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Upadding.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //_____________Header__________________
            //___________title & subtitle_________
            UHeader(),
            // ________sizedbox_________
            SizedBox(height: USizes.spaceBtwItems),

            //  ___________form___________________
            ULoginForm(),
            // ______________divider______________
            SizedBox(height: USizes.spaceBtwInputFields),
            //divider
            UDivider(title: UTexts.orSignInWith),
            SizedBox(height: USizes.spaceBtwSections),
            // google sigin & facebook
            USocialButton(),
          ],
        ),
      ),
    );
  }
}
