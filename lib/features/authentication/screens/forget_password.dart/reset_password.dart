import 'package:e_commerce/common/style/padding.dart';
import 'package:e_commerce/features/authentication/controller/forget_password/forget_password_controller.dart';
import 'package:e_commerce/features/authentication/screens/Login/login_screen.dart';
import 'package:e_commerce/common/widget/button/elevated_button.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/helpers/device_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    final controller = ForgetPasswordController.instance;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyActions: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => LoginScreen()),
            icon: Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Upadding.screenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                UImages.mailSentImage,
                height: UDeviceHelper.getScreenHeight(context) * 0.4,
              ),
              Text(
                UTexts.resetPasswordTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(UTexts.resetPasswordSubTitle, textAlign: TextAlign.center),

              SizedBox(height: USizes.spaceBtwSections),

              UElevatedButton(onPressed: () {}, child: Text(UTexts.done)),

              TextButton(
                onPressed: () {
                  controller.sendPasswordResetEmail();
                },
                child: Text(
                  "Resend Email",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
