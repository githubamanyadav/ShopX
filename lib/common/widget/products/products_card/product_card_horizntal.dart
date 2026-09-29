import 'package:e_commerce/common/custom_shapes/clipper/rounded_container.dart';
import 'package:e_commerce/common/widget/brands/brand_cards.dart';
import 'package:e_commerce/common/widget/icon/circular_icon.dart';
import 'package:e_commerce/common/widget/images/rounded_images.dart';
import 'package:e_commerce/common/widget/text/brand_title_with_verification_icon.dart';
import 'package:e_commerce/common/widget/text/product_price_text.dart';
import 'package:e_commerce/common/widget/text/product_text_title.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:iconsax/iconsax.dart';

class UProductHorizontalCard extends StatelessWidget {
  const UProductHorizontalCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunction.isDarkMode(context);
    return Container(
      width: 310,
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(USizes.productImageRadius),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ), // BoxDecoration
      child: Row(
        children: [
          /// Thumbnail
          URoundedContainer(
            backgroundColor: dark ? UColors.dark : UColors.light,
            height: 120,

            padding: EdgeInsets.all(USizes.sm),
            child: Stack(
              children: [
                //thumbanail image
                SizedBox(
                  height: 120,
                  width: 120,

                  child: URoundedImage(imageUrl: UImages.productImage11),
                ),
                //discount tag
                Positioned(
                  top: 12,
                  child: URoundedContainer(
                    radius: USizes.sm,
                    backgroundColor: UColors.yellow.withValues(alpha: 0.4),
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
                ),

                //fav icon  heart
                Positioned(
                  right: -5,
                  top: 0,
                  child: UCircularIcon(icon: Iconsax.heart5, color: Colors.red),
                ),
              ],
            ),
          ),

          /// right side Details
          SizedBox(
            width: 172,
            child: Padding(
              padding: const EdgeInsets.only(left: USizes.sm, top: USizes.sm),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UProductTextTitle(
                        title: "jockey black shocks",
                        smallSize: true,
                      ),
                      SizedBox(height: USizes.spaceBtwItems / 2),
                      UBrandTitleWithVerifyIcon(title: "jockey"),
                    ],
                  ),
                  Spacer(),
                  //price & add button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: UProductPriceText(
                          currentSign: "\$",
                          price: "61",
                          maxLines: 1,
                          isLarge: false,
                          lineThrough: false,
                        ),
                      ),

                      Container(
                        height: USizes.iconLg * 1.2,
                        width: USizes.iconLg * 1.2,
                        decoration: BoxDecoration(
                          color: UColors.primary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(USizes.cardRadiusMd),
                            bottomRight: Radius.circular(
                              USizes.productImageRadius,
                            ),
                          ),
                        ),
                        child: Icon(Iconsax.add, color: UColors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
