import 'package:e_commerce/common/custom_shapes/clipper/rounded_container.dart';

import 'package:e_commerce/common/widget/images/circular_image.dart';
import 'package:e_commerce/common/widget/text/brand_title_with_verification_icon.dart';
import 'package:e_commerce/common/widget/text/product_price_text.dart';
import 'package:e_commerce/common/widget/text/product_text_title.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UProductMetaData extends StatelessWidget {
  const UProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            URoundedContainer(
              radius: USizes.sm,
              backgroundColor: UColors.yellow.withValues(alpha: 0.8),
              padding: EdgeInsets.symmetric(
                horizontal: USizes.sm,
                vertical: USizes.xs,
              ),
              child: Text(
                '20%',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.apply(color: UColors.black),
              ),
            ),

            SizedBox(width: USizes.spaceBtwItems),

            Text(
              "\$250",
              style: Theme.of(context).textTheme.titleSmall!.apply(
                decoration: TextDecoration.lineThrough,
              ),
            ),

            SizedBox(width: USizes.spaceBtwItems),

            UProductPriceText(price: '150', isLarge: true),

            Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Iconsax.share)),
          ],
        ),
        SizedBox(height: USizes.spaceBtwItems / 1.5),

        /// Product Title
        UProductTextTitle(title: 'Apple iPhone 11'),
        SizedBox(height: USizes.spaceBtwItems / 1.5),

        /// Product Status
        Row(
          children: [
            UProductTextTitle(title: 'Status'),
            SizedBox(width: USizes.spaceBtwItems),
            Text('In Stock', style: Theme.of(context).textTheme.titleMedium),
          ],
        ), // Row
        SizedBox(height: USizes.spaceBtwItems / 1.5),

        Row(
          children: [
            UCircularImage(image: UImages.appleLogo, width: 32.0, height: 32.0),
            SizedBox(width: USizes.spaceBtwItems),
            UBrandTitleWithVerifyIcon(title: 'Apple'),
          ],
        ), // Row
      ],
    );
  }
}
