import 'package:e_commerce/common/widget/images/circular_image.dart';
import 'package:e_commerce/common/widget/shimmer/shimmer_effect.dart';
import 'package:e_commerce/features/personalization/screens/controller/user_controller.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class UserProfileLogo extends StatelessWidget {
  const UserProfileLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Obx(() {
      //
      if (controller.isProfileUploading.value) {
        return UShimmerEffect(width: 120, height: 120, radius: 120);
      }
      final isProfileAvailable =
          controller.user.value.profilePicture.isNotEmpty;

      return UCircularImage(
        image: isProfileAvailable
            ? controller.user.value.profilePicture
            : UImages.profileLogo,
        height: 120,
        width: 120,
        padding: 0,
        borderWidth: 5.0,
        borderColor: UColors.buttonPrimary,
        isNetworkImage: isProfileAvailable,
      );
    });
  }
}
