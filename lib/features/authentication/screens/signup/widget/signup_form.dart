import 'package:e_commerce/common/widget/button/elevated_button.dart';
import 'package:e_commerce/features/authentication/controller/signup/signup_controller.dart';

import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/validator/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:iconsax/iconsax.dart';

class USignUpForm extends StatelessWidget {
  const USignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignUpController.instance;
    return Form(
      key: controller.signUpformKey,
      child: Column(
        children: [
          // First & Last Name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      UValidator.validateEmptyText('First Name', value),
                  decoration: InputDecoration(
                    labelText: UTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              SizedBox(width: USizes.spaceBtwInputFields),

              //last name
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      UValidator.validateEmptyText('Last name', value),
                  decoration: InputDecoration(
                    labelText: UTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),

          // email , phone number & password
          SizedBox(height: USizes.spaceBtwInputFields),
          //remaining input forms field
          //email field
          TextFormField(
            controller: controller.email,
            validator: (value) => UValidator.validateEmail(value),
            decoration: InputDecoration(
              labelText: UTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),

          SizedBox(height: USizes.spaceBtwInputFields),
          //phone number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => UValidator.validatePhoneNumber(value),
            decoration: InputDecoration(
              labelText: UTexts.phoneNumber,
              prefixIcon: Icon(Icons.phone_outlined),
            ),
          ),

          SizedBox(height: USizes.spaceBtwInputFields),
          //password
          Obx(
            () => TextFormField(
              obscureText: controller.isPasswordVisible.value,

              controller: controller.password,
              validator: (value) => UValidator.validatePassword(value),
              decoration: InputDecoration(
                labelText: UTexts.password,
                suffixIcon: IconButton(
                  onPressed: () => controller.isPasswordVisible.value =
                      !controller.isPasswordVisible.value,
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
                prefixIcon: IconButton(
                  onPressed: () => controller.isPasswordVisible.value =
                      !controller.isPasswordVisible.value,
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Iconsax.password_check
                        : Iconsax.password_check,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: USizes.spaceBtwInputFields),

          // check box with agreement
          Row(
            children: [
              Obx(
                () => Checkbox(
                  value: controller.privacyPolicy.value,
                  onChanged: (value) {
                    controller.privacyPolicy.value =
                        !controller.privacyPolicy.value;
                  },
                ),
              ),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(text: '${UTexts.iAgreeTo} '),
                    TextSpan(
                      text: '${UTexts.privacyPolicy} ',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: UColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: UTexts.termsOfUse,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: UColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: USizes.spaceBtwSections),
          // SignUp Button
          UElevatedButton(
            onPressed: () => controller.registerUser(),
            child: Text("Create Account"),
          ),
          SizedBox(height: USizes.spaceBtwSections),
        ],
      ),
    );
  }
}
