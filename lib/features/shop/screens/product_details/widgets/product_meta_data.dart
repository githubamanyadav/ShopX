import 'dart:async';

import 'package:e_commerce/common/custom_shapes/clipper/rounded_container.dart';

import 'package:e_commerce/common/widget/images/circular_image.dart';
import 'package:e_commerce/common/widget/text/brand_title_with_verification_icon.dart';
import 'package:e_commerce/common/widget/text/product_price_text.dart';
import 'package:e_commerce/common/widget/text/product_text_title.dart';
import 'package:e_commerce/features/shop/controller/product/product_controller.dart';
import 'package:e_commerce/features/shop/models/products/products.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/enums.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UProductMetaData extends StatelessWidget {
  const UProductMetaData({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salesPercentage = controller.calculateSalePercentage(
      product.price,
      product.salePrice,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (salesPercentage != null) ...[
              URoundedContainer(
                radius: USizes.sm,
                backgroundColor: UColors.yellow.withValues(alpha: 0.8),
                padding: EdgeInsets.symmetric(
                  horizontal: USizes.sm,
                  vertical: USizes.xs,
                ),
                child: Text(
                  "$salesPercentage%",
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.apply(color: UColors.black),
                ),
              ),

              SizedBox(width: USizes.spaceBtwItems),
            ],
            //actual price
            if (product.productType == ProductType.single &&
                product.salePrice > 0) ...[
              Text(
                "${UTexts.currency}${product.price}",
                style: Theme.of(context).textTheme.titleSmall!.apply(
                  decoration: TextDecoration.lineThrough,
                ),
              ),

              SizedBox(width: USizes.spaceBtwItems),
            ],

            //sales price
            UProductPriceText(
              price: controller.getProductPrice(product),
              isLarge: true,
            ),

            Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Iconsax.share)),
          ],
        ),
        SizedBox(height: USizes.spaceBtwItems / 1.5),

        /// Product Title
        UProductTextTitle(title: product.brand!.name),
        SizedBox(height: USizes.spaceBtwItems / 1.5),

        /// Product Status
        Row(
          children: [
            UProductTextTitle(title: 'Status'),
            SizedBox(width: USizes.spaceBtwItems),
            Text(
              controller.getStockStatus(product.stock),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ), // Row
        SizedBox(height: USizes.spaceBtwItems / 1.5),

        Row(
          children: [
            UCircularImage(
              isNetworkImage: true,
              image: product.brand != null ? product.brand!.image : " ",
              width: 32.0,
              height: 32.0,
            ),
            SizedBox(width: USizes.spaceBtwItems),
            UBrandTitleWithVerifyIcon(
              title: product.brand != null ? product.brand!.name : " ",
            ),
          ],
        ), // Row
      ],
    );
  }
}
