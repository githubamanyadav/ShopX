import 'package:e_commerce/common/widget/products/cart/cart_item/cart_item.dart';
import 'package:e_commerce/common/widget/products/cart/product_quantity_with_add_button.dart';
import 'package:e_commerce/common/widget/text/product_price_text.dart';
import 'package:e_commerce/features/shop/controller/cart_system/cart_controller.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class UCartItems extends StatelessWidget {
  const UCartItems({super.key, this.isShowButtons = true});
  final bool isShowButtons;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) => SizedBox(height: USizes.spaceBtwItems),
        itemCount: controller.cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = controller.cartItems[index];
          return Column(
            children: [
              UCartItem(cartItem: cartItem),
              if (isShowButtons) SizedBox(height: USizes.spaceBtwItems),
              if (isShowButtons)
                Row(
                  children: [
                    UProductWithAddButton(
                      quantity: cartItem.quantity,
                      add: () => controller.addToOneCart(cartItem),
                      remove: () => controller.removeOneFromCart(cartItem),
                    ),

                    const Spacer(),
                    UProductPriceText(
                      price: (cartItem.price * cartItem.quantity)
                          .toStringAsFixed(1),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
