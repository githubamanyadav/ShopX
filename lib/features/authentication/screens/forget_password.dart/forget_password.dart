import 'package:e_commerce/common/style/padding.dart';
import 'package:e_commerce/features/authentication/controller/forget_password/forget_password_controller.dart';

import 'package:e_commerce/common/widget/button/elevated_button.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/validator/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';

import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: Upadding.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              UTexts.forgetPassword,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              UTexts.forgetPasswordSubTitle,
              style: Theme.of(context).textTheme.bodySmall,
            ),

            SizedBox(height: USizes.spaceBtwSections),

            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                validator: (value) => UValidator.validateEmail(value),
                controller: controller.email,
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.direct),
                  hintText: UTexts.email,
                ),
              ),
            ),

            SizedBox(height: USizes.spaceBtwInputFields),

            UElevatedButton(
              onPressed: () {
                controller.sendPasswordResetEmail();
              },
              child: Text(UTexts.submit),
            ),
          ],
        ),
      ),
    );
  }
}
