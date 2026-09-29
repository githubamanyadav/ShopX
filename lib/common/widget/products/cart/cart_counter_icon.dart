import 'package:e_commerce/features/shop/screens/cart/cart.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';

class UCartCounterIcon extends StatelessWidget {
  const UCartCounterIcon({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = UHelperFunction.isDarkMode(context);
    return Stack(
      children: [
        IconButton(
          onPressed: () {
            Get.to(() => CartScreen());
          },
          icon: Icon(Iconsax.shopping_bag),
          color: dark ? UColors.dark : UColors.white,
        ),

        Positioned(
          top: 2,
          right: 6,
          child: Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(
              color: dark ? UColors.dark : UColors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "7",
                style: Theme.of(context).textTheme.labelLarge!.apply(
                  fontSizeFactor: 0.8,
                  color: dark ? UColors.white : UColors.dark,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
