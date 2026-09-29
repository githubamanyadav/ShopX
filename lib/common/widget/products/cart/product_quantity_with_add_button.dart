import 'package:e_commerce/common/widget/icon/circular_icon.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UProductWithAddButton extends StatelessWidget {
  const UProductWithAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunction.isDarkMode(context);
    return Row(
      children: [
        SizedBox(width: 70),
        UCircularIcon(
          height: 32,
          width: 32,
          size: USizes.iconSm,
          icon: Iconsax.minus,
          backgroundColor: dark ? UColors.darkGrey : UColors.light,
          color: dark ? UColors.white : UColors.black,
        ),
        SizedBox(width: USizes.spaceBtwItems),
        Text("2", style: Theme.of(context).textTheme.titleSmall),
        SizedBox(width: USizes.spaceBtwItems),
        UCircularIcon(
          height: 32,
          width: 32,
          size: USizes.iconSm,
          icon: Iconsax.add,
          backgroundColor: UColors.primary,
          color: UColors.white,
        ),
      ],
    );
  }
}
