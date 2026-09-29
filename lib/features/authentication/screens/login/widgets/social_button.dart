import 'package:e_commerce/features/authentication/controller/login/login_controller.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class USocialButton extends StatelessWidget {
  USocialButton({super.key});
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildSocialButton(UImages.googleIcon, () {
          controller.googleSignIn();
        }),
        SizedBox(width: USizes.spaceBtwItems),
        buildSocialButton(UImages.facebookIcon, () {}),
      ],
    );
  }

  Container buildSocialButton(String image, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: UColors.grey),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Image.asset(image, height: USizes.iconMd, width: USizes.iconMd),
      ),
    );
  }
}
