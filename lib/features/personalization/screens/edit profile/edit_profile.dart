import 'package:e_commerce/common/widget/appbar/app_bar.dart';

import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/features/personalization/screens/controller/user_controller.dart';
import 'package:e_commerce/features/personalization/screens/edit%20profile/widgets/change_name.dart';
import 'package:e_commerce/features/personalization/screens/edit%20profile/widgets/user_detail_row.dart';
import 'package:e_commerce/features/personalization/screens/edit%20profile/widgets/user_profile_with_edit_icon.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:get/state_manager.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: UAppBar(
        showArrowBack: true,
        title: Text(
          "Edit profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(USizes.md),
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserProfileWithEditIcon(),

              SizedBox(height: USizes.spaceBtwSections),

              /// Divider
              Divider(),
              SizedBox(height: USizes.spaceBtwItems),

              /// Account Settings Heading
              USectionHeading(
                title: 'Account Settings',
                showActionButton: false,
              ),

              /// Account Details
              Obx(
                () => UserDetailRow(
                  title: 'Name',
                  value: controller.user.value.fullName,
                  onTap: () {
                    Get.to(() => ChangeName());
                  },
                ),
              ),
              UserDetailRow(
                title: 'Username',
                value: controller.user.value.username,
                onTap: () {},
              ),
              SizedBox(height: USizes.spaceBtwItems),

              /// Divider
              Divider(),
              SizedBox(height: USizes.spaceBtwItems),

              /// Profile Section Heading
              USectionHeading(
                title: 'Profile Settings',
                showActionButton: false,
              ),
              SizedBox(height: USizes.spaceBtwItems),

              /// Profile Settings
              UserDetailRow(
                title: 'User ID',
                value: controller.user.value.id,
                onTap: () {},
              ),
              UserDetailRow(
                title: 'Email',
                value: controller.user.value.email,
                onTap: () {},
              ),
              UserDetailRow(
                title: 'Phone Number',
                value: "+91 ${controller.user.value.phoneNumber}",
                onTap: () {},
              ),
              UserDetailRow(title: 'Gender', value: 'Male', onTap: () {}),
              SizedBox(height: USizes.spaceBtwItems),

              /// Divider
              Divider(),
              SizedBox(height: USizes.spaceBtwItems),

              /// Close Account Button
              TextButton(
                onPressed: () {
                  controller.deleteAccountWarningPopup(context);
                },
                child: Text(
                  'Close Account',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
