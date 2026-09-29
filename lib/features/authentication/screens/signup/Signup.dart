import 'package:e_commerce/common/style/padding.dart';
import 'package:e_commerce/features/authentication/controller/signup/signup_controller.dart';

import 'package:e_commerce/features/authentication/screens/Login/widgets/divider.dart';

import 'package:e_commerce/features/authentication/screens/login/widgets/social_button.dart';

import 'package:e_commerce/features/authentication/screens/signup/widget/signup_form.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: Upadding.screenPadding,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //-------header--------------
            Text(
              UTexts.signupTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: USizes.spaceBtwSections),
            // sign up form
            USignUpForm(),
            //divider - signwith
            UDivider(title: UTexts.orSignInWith),
            SizedBox(height: USizes.spaceBtwItems),
            //social media button
            USocialButton(),

            //Sigin form
          ],
        ),
      ),
    );
  }
}
