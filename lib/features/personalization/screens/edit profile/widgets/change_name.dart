import 'package:e_commerce/common/style/padding.dart';
import 'package:e_commerce/common/widget/appbar/app_bar.dart';
import 'package:e_commerce/common/widget/button/elevated_button.dart';
import 'package:e_commerce/features/personalization/screens/controller/change_name_controller.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/validator/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangeNameController());
    return Scaffold(
      appBar: UAppBar(title: Text("Update Name"), showArrowBack: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: Upadding.screenPadding,
          child: Column(
            children: [
              Text(
                "Update Your Name to keep Your profile accurate and Personalize",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(height: USizes.spaceBtwItems),

              Form(
                key: controller.updateUserFormkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.firstName,
                      validator: (value) =>
                          UValidator.validateEmptyText('First Name', value),
                      decoration: InputDecoration(
                        labelText: UTexts.firstName,
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                    SizedBox(height: USizes.spaceBtwItems),
                    TextFormField(
                      controller: controller.lastName,
                      validator: (value) =>
                          UValidator.validateEmptyText('Last Name', value),
                      decoration: InputDecoration(
                        labelText: UTexts.lastName,
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: USizes.spaceBtwSections),
              UElevatedButton(
                onPressed: () {
                  controller.updateUserName();
                },
                child: Text("save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
