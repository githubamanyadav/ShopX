import 'package:e_commerce/common/widget/icon/circular_icon.dart';
import 'package:e_commerce/features/shop/controller/cart_system/cart_controller.dart';
import 'package:e_commerce/features/shop/models/products/products.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UBottomAddToCart extends StatelessWidget {
  const UBottomAddToCart({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final dark = UHelperFunction.isDarkMode(context);
    controller.updateAlreadyAddedProductCount(product);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: USizes.defaultSpace,
        vertical: USizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? UColors.darkGrey : UColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(USizes.cardRadiusLg),
          topRight: Radius.circular(USizes.cardRadiusLg),
        ),
      ),
      child: Obx(
        () => Row(
          children: [
            /// Decrement Button
            UCircularIcon(
              onPressed: controller.productQuantityInCart.value < 1
                  ? null
                  : () => controller.productQuantityInCart.value -= 1,

              icon: Iconsax.minus,
              backgroundColor: UColors.darkGrey,
              width: 40,
              height: 40,
              color: UColors.white,
            ),
            SizedBox(width: USizes.spaceBtwItems),

            /// Counter
            Text(
              controller.productQuantityInCart.value.toString(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(width: USizes.spaceBtwItems),

            /// Increment Button
            UCircularIcon(
              onPressed: () => controller.productQuantityInCart.value += 1,
              icon: Iconsax.add,
              backgroundColor: UColors.black,
              width: 40,
              height: 40,
              color: UColors.white,
            ),
            Spacer(),

            /// Add to Cart Button
            ElevatedButton(
              onPressed: controller.productQuantityInCart.value < 1
                  ? null
                  : () => controller.addToCart(product),

              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(USizes.md),
                backgroundColor: UColors.black,
                side: BorderSide(color: UColors.black),
              ),
              child: Row(
                children: [
                  Icon(Iconsax.shopping_bag),
                  SizedBox(width: USizes.spaceBtwItems / 2),
                  Text('Add To Cart'),
                ],
              ), // child Row
            ), // ElevatedButton
          ], // outer Row children
        ),
      ), // outer Row
    ); // Container
  }
}
