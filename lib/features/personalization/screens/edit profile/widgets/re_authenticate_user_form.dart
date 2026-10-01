import 'package:e_commerce/common/style/padding.dart';
import 'package:e_commerce/common/widget/appbar/app_bar.dart';
import 'package:e_commerce/common/widget/button/elevated_button.dart';
import 'package:e_commerce/features/personalization/screens/controller/user_controller.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/validator/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: const UAppBar(
        title: Text('Re-Authenticate User'),
        showArrowBack: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Upadding.screenPadding,
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              children: [
                /// Email
                TextFormField(
                  controller: controller.email,
                  validator: UValidator.validateEmail,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: UTexts.email,
                  ),
                ),
                SizedBox(height: USizes.spaceBtwItems),

                /// Password
                TextFormField(
                  controller: controller.password,
                  obscureText: controller.isPasswordVisible.value,
                  validator: (value) =>
                      UValidator.validateEmptyText('Password', value),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.password_check),
                    labelText: UTexts.password,
                    suffixIcon: IconButton(
                      onPressed: () => controller.isPasswordVisible.toggle(),
                      icon: controller.isPasswordVisible.value
                          ? Icon(Iconsax.eye_slash)
                          : Icon(Iconsax.eye_slash),
                    ),
                  ),
                ),
                SizedBox(height: USizes.spaceBtwItems),

                /// Verify Button
                UElevatedButton(
                  onPressed: () {
                    controller.reAuthenticateUser();
                  },
                  child: const Text('Verify'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
