import 'package:e_commerce/common/widget/appbar/app_bar.dart';
import 'package:e_commerce/common/widget/icon/circular_icon.dart';
import 'package:e_commerce/common/widget/images/rounded_images.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UProductThumbnailAndSlider extends StatelessWidget {
  const UProductThumbnailAndSlider({super.key, required this.dark});

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //thumbnail or the image
        SizedBox(
          height: 400,
          child: Padding(
            padding: EdgeInsetsGeometry.all(USizes.productImageRadius * 2),
            child: Center(
              child: Image(image: AssetImage(UImages.productImage2)),
            ),
          ),
        ),

        //image slider
        Positioned(
          left: USizes.defaultSpace,
          right: 0,
          bottom: 30,
          child: SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              separatorBuilder: (context, index) =>
                  SizedBox(width: USizes.spaceBtwItems),
              itemCount: 10,
              itemBuilder: (context, index) => URoundedImage(
                width: 80,
                imageUrl: UImages.productImage10,
                padding: EdgeInsets.all(USizes.sm),
                backgroundColor: dark ? UColors.dark : UColors.white,
                border: Border.all(color: UColors.primary),
              ),
            ),
          ),
        ),

        //arrow navigation & fav button
        UAppBar(
          showArrowBack: true,
          actions: [UCircularIcon(icon: Iconsax.heart5, color: Colors.red)],
        ),
      ],
    );
  }
}
