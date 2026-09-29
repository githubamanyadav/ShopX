import 'package:e_commerce/common/custom_shapes/clipper/rounded_container.dart';
import 'package:e_commerce/common/style/shadow.dart';
import 'package:e_commerce/common/widget/icon/circular_icon.dart';
import 'package:e_commerce/common/widget/images/rounded_images.dart';

import 'package:e_commerce/common/widget/text/brand_title_with_verification_icon.dart';
import 'package:e_commerce/common/widget/text/product_price_text.dart';
import 'package:e_commerce/common/widget/text/product_text_title.dart';
import 'package:e_commerce/features/shop/screens/product_details/product_details.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UProductsCardVetrtical extends StatelessWidget {
  const UProductsCardVetrtical({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = UHelperFunction.isDarkMode(context);
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailScreen());
      },
      child: Container(
        width: 180,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: UShadow.verticalProductShadow,
          borderRadius: BorderRadius.circular(USizes.productImageRadius),
          color: dark ? UColors.darkGrey : UColors.white,
        ),
        child: Column(
          children: [
            //upper portion of the Product card
            URoundedContainer(
              height: 180,
              padding: EdgeInsets.all(USizes.sm),
              backgroundColor: dark ? UColors.dark : UColors.light,
              child: Stack(
                children: [
                  Center(
                    child: URoundedImage(imageUrl: UImages.productImage15),
                  ),
                  Positioned(
                    top: 12,
                    child: URoundedContainer(
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
                  ),
                  Positioned(
                    right: -5,
                    top: 0,
                    child: UCircularIcon(
                      icon: Iconsax.heart5,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: USizes.spaceBtwItems / 2),

            //lower portion of the product card detail
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: USizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UProductTextTitle(
                      title: "Bata shoes",
                      smallSize: true,
                      maxLines: 1,
                    ),
                    SizedBox(height: USizes.xs),
                    UBrandTitleWithVerifyIcon(title: "Bata"),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UProductPriceText(
                          currentSign: "\$",
                          price: "61",
                          maxLines: 1,
                          isLarge: false,
                          lineThrough: false,
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
      ),
    );
  }
}
