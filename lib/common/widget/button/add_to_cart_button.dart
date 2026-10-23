import 'package:e_commerce/features/shop/controller/cart_system/cart_controller.dart';
import 'package:e_commerce/features/shop/models/cart_system/cart_item_model.dart';
import 'package:e_commerce/features/shop/models/products/products.dart';
import 'package:e_commerce/features/shop/screens/product_details/product_details.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/enums.dart';
import 'package:e_commerce/utils/constants/sizes.dart';

import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';

import 'package:iconsax/iconsax.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return InkWell(
      onTap: () {
        if (product.productType == ProductType.single.toString()) {
          CartItemModel cartItem = controller.convertToCartItem(product, 1);
          controller.addToOneCart(cartItem);
        } else {
          Get.to(() => ProductDetailScreen(product: product));
        }
      },
      child: Obx(() {
        final productQuantityInCart = controller.getProductQuantityInCart(
          product.id,
        );
        return Container(
          height: USizes.iconLg * 1.2,
          width: USizes.iconLg * 1.2,
          decoration: BoxDecoration(
            color: productQuantityInCart > 0 ? UColors.black : UColors.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(USizes.cardRadiusMd),
              bottomRight: Radius.circular(USizes.productImageRadius),
            ),
          ),
          child: Center(
            child: productQuantityInCart > 0
                ? Text(
                    productQuantityInCart.toString(),
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.apply(color: UColors.white),
                  )
                : Icon(Iconsax.add, color: UColors.white),
          ),
        );
      }),
    );
  }
}
