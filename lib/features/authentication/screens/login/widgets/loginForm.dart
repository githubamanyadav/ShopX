import 'package:e_commerce/common/widget/button/elevated_button.dart';
import 'package:e_commerce/features/authentication/controller/login/login_controller.dart';
import 'package:e_commerce/features/authentication/screens/forget_password.dart/forget_password.dart';

import 'package:e_commerce/features/authentication/screens/signup/Signup.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/validator/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ULoginForm extends StatelessWidget {
  const ULoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.instance;
    return Form(
      key: controller.loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          TextFormField(
            validator: (value) => UValidator.validateEmail(value),
            controller: controller.email,
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: UTexts.email,
            ),
          ),
          SizedBox(height: USizes.spaceBtwInputFields),
          Obx(
            () => TextFormField(
              obscureText: controller.isPasswordVisible.value,
              controller: controller.password,
              validator: (value) =>
                  UValidator.validateEmptyText("Password", value),
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: UTexts.password,
                suffixIcon: IconButton(
                  onPressed: () => controller.isPasswordVisible.toggle(),
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: USizes.spaceBtwInputFields / 2),

          // remember me checkbox & forgot password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: controller.isRememberMe.value,
                      onChanged: (value) => controller.isRememberMe.toggle(),
                    ),
                  ),
                  Text(UTexts.rememberMe),
                ],
              ),

              TextButton(
                onPressed: () {
                  Get.to(() => ForgetPassword());
                },
                child: Text(UTexts.forgetPassword),
              ),
            ],
          ),
          SizedBox(height: USizes.spaceBtwSections),
          //sigin button
          UElevatedButton(
            onPressed: () => controller.loginWithEmailAndPassword(),
            child: Text(UTexts.signIn),
          ),
          SizedBox(height: USizes.spaceBtwSections / 2),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Get.to(() => SignIn()),
              child: Text(UTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
