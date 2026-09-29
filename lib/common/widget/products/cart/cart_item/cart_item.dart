import 'package:e_commerce/common/widget/images/rounded_images.dart';
import 'package:e_commerce/common/widget/text/brand_title_with_verification_icon.dart';
import 'package:e_commerce/common/widget/text/product_text_title.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class UCartItem extends StatelessWidget {
  const UCartItem({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunction.isDarkMode(context);
    return Row(
      children: [
        /// Product Image
        URoundedImage(
          imageUrl: UImages.productImage4a,
          height: 60.0,
          width: 60.0,
          padding: EdgeInsets.all(USizes.md),

          backgroundColor: dark ? UColors.darkerGrey : UColors.light,
        ), // URoundedImage
        SizedBox(width: USizes.spaceBtwItems),

        /// Brand, Name, Variation
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UBrandTitleWithVerifyIcon(title: 'iPhone'),
              UProductTextTitle(title: 'iPhone 11 64 GB W'),

              //detail of the products
              /// Variation OR Attributes
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Color ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: 'Green ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: 'Storage ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: '512GB ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ), // TextSpan, RichText
            ],
          ),
        ), // Column, Expanded
      ],
    );
  }
}
