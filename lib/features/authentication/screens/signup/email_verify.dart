import 'package:e_commerce/common/style/padding.dart';
import 'package:e_commerce/data/repository/authentication_repository.dart';

import 'package:e_commerce/features/authentication/controller/signup/verify_email_controller.dart';

import 'package:e_commerce/common/widget/button/elevated_button.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/helpers/device_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerifyScreen extends StatelessWidget {
  const EmailVerifyScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyActions: false,
        actions: [
          IconButton(
            onPressed: AuthenticationRepository.instance.logout,
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
                UTexts.verifyEmailTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: USizes.spaceBtwInputFields),
              Text(email ?? " ", style: Theme.of(context).textTheme.bodySmall),
              SizedBox(height: USizes.spaceBtwInputFields),
              Text(UTexts.verifyEmailSubTitle, textAlign: TextAlign.center),

              SizedBox(height: USizes.spaceBtwSections),

              UElevatedButton(
                onPressed: controller.checkEmailverificationStatus,
                child: Text(UTexts.uContinue),
              ),

              TextButton(
                onPressed: controller.sendEmailverification,

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
