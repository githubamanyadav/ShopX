import 'package:e_commerce/common/widget/images/circular_image.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:flutter/material.dart';

class UserProfileLogo extends StatelessWidget {
  const UserProfileLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return UCircularImage(
      image: UImages.profileLogo,
      height: 120,
      width: 120,
      padding: 0,
      borderWidth: 5.0,
      borderColor: UColors.buttonPrimary,
    );
  }
}
