import 'package:e_commerce/common/widget/icon/circular_icon.dart';
import 'package:e_commerce/common/widget/images/user_profile_logo.dart';
import 'package:e_commerce/features/personalization/screens/controller/user_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';

class UserProfileWithEditIcon extends StatelessWidget {
  const UserProfileWithEditIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Stack(
      children: [
        Center(child: UserProfileLogo()),

        Obx(() {
          if (controller.isProfileUploading.value) {
            return SizedBox();
          }
          return Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(
              child: UCircularIcon(
                icon: Iconsax.edit,
                onPressed: controller.updateUserprofilePicture,
              ),
            ),
          );
        }),
      ],
    );
  }
}
