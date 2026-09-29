import 'package:e_commerce/common/widget/appbar/app_bar.dart';

import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/features/personalization/screens/edit%20profile/widgets/user_detail_row.dart';
import 'package:e_commerce/features/personalization/screens/edit%20profile/widgets/user_profile_with_edit_icon.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
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
              USectionHeading(title: 'Account Settings'),

              /// Account Details
              UserDetailRow(title: 'Name', value: 'Unknown Pro', onTap: () {}),
              UserDetailRow(
                title: 'Username',
                value: 'unknownpro12',
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
              UserDetailRow(title: 'User ID', value: '312312', onTap: () {}),
              UserDetailRow(
                title: 'Email',
                value: 'unknownpro@gmail.com',
                onTap: () {},
              ),
              UserDetailRow(
                title: 'Phone Number',
                value: '+923123456789',
                onTap: () {},
              ),
              UserDetailRow(title: 'Gender', value: 'Male', onTap: () {}),
              SizedBox(height: USizes.spaceBtwItems),

              /// Divider
              Divider(),
              SizedBox(height: USizes.spaceBtwItems),

              /// Close Account Button
              TextButton(
                onPressed: () {},
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
