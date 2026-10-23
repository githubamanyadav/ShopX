import 'package:e_commerce/common/style/padding.dart';
import 'package:e_commerce/common/widget/animation/animation_loader.dart';
import 'package:e_commerce/common/widget/appbar/app_bar.dart';
import 'package:e_commerce/common/widget/button/elevated_button.dart';
import 'package:e_commerce/common/widget/icon/circular_icon.dart';
import 'package:e_commerce/features/shop/controller/cart_system/cart_controller.dart';

import 'package:e_commerce/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:e_commerce/features/shop/screens/checkout/checkout.dart';
import 'package:e_commerce/utils/constants/images.dart';

import 'package:e_commerce/utils/constants/sizes.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: UAppBar(
        showArrowBack: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          UCircularIcon(
            icon: Iconsax.box_remove,
            onPressed: () => controller.clearCart(),
          ),
        ],
      ),
      body: Obx(() {
        final emptyWidget = UAnimationLoader(
          text: 'Cart is empty',
          animation: UImages.cartEmptyAnimation,
          showActionButton: true,
          actionText: "Let's fill it",
          onActionPressed: Get.back,
        );

        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        }
        return SingleChildScrollView(
          child: Padding(padding: Upadding.screenPadding, child: UCartItems()),
        );
      }),

      /// ------[BottomNavigation]------
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(USizes.defaultSpace),
        child: UElevatedButton(
          onPressed: () {
            Get.to(() => CheckoutScreen());
          },
          child: Obx(
            () => Text(
              'Checkout \$${controller.totalCartPrice.value.toStringAsFixed(1)}',
            ),
          ),
        ),
      ),
    );
  }
}
